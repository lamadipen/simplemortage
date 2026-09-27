/**
 * Quick quote form backend for smortgageloan.com.
 *
 * Bound to the "Simple Mortgage quote requests" Google Sheet. The website
 * POSTs each quote request here (AppsScriptQuoteSubmissionService in
 * lib/features/home/widgets/quick_quote_section.dart); this script appends it
 * to the Leads tab and emails everyone listed in the Recipients tab.
 *
 * Setup: Extensions > Apps Script, paste this file, add the reCAPTCHA secret
 * key as Script Property RECAPTCHA_SECRET (Project Settings), run setupSheet()
 * once, then Deploy > New deployment > Web app (Execute as: Me, Access:
 * Anyone). After later edits, run setupSheet() again and deploy a new version.
 */

const LEADS_SHEET = 'Leads';
const RECIPIENTS_SHEET = 'Recipients';
const LEAD_HEADERS = [
  'Submitted at', 'First name', 'Last name', 'Email', 'Phone', 'Home price',
  'Down payment', 'Loan amount', 'Credit range', 'Message', 'Email status',
  'reCAPTCHA score',
];
const EMAIL_STATUS_COLUMN = 11;
// reCAPTCHA v3 scores run from 0.0 (bot) to 1.0 (human). Raise this if junk
// leads get through; lower it if real visitors are rejected (see the
// reCAPTCHA score column).
const RECAPTCHA_MIN_SCORE = 0.5;
const RECAPTCHA_ACTION = 'quote';
const ALLOWED_HOSTNAMES = [
  'smortgageloan.com', 'www.smortgageloan.com',
  'simplemortage.web.app', 'simplemortage.firebaseapp.com', 'localhost',
];
const CREDIT_RANGES = ['760+', '700-759', '660-699', '620-659', 'Below 620', 'Unsure'];

/**
 * Run from the editor after pasting a new version: creates both tabs, updates
 * the Leads header row, and grants mail and URL-fetch permission.
 */
function setupSheet() {
  const spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  const leads = spreadsheet.getSheetByName(LEADS_SHEET) || spreadsheet.insertSheet(LEADS_SHEET);
  leads.getRange(1, 1, 1, LEAD_HEADERS.length)
    .setValues([LEAD_HEADERS])
    .setFontWeight('bold');
  leads.setFrozenRows(1);
  const recipients =
    spreadsheet.getSheetByName(RECIPIENTS_SHEET) || spreadsheet.insertSheet(RECIPIENTS_SHEET);
  if (recipients.getLastRow() === 0) {
    recipients.appendRow(['Email (one per row)']);
    recipients.appendRow(['ganesh@smortgageloan.com']);
    recipients.setFrozenRows(1);
    recipients.getRange(1, 1).setFontWeight('bold');
  }
  if (!PropertiesService.getScriptProperties().getProperty('RECAPTCHA_SECRET')) {
    Logger.log('WARNING: Script Property RECAPTCHA_SECRET is not set; all requests will be rejected.');
  }
  Logger.log('Remaining email quota today: ' + MailApp.getRemainingDailyQuota());
}

function doPost(e) {
  let quote;
  try {
    quote = JSON.parse(e.postData.contents);
  } catch (error) {
    return jsonResponse({ok: false, error: 'invalid_json'});
  }
  if (!quote || typeof quote !== 'object') return jsonResponse({ok: false, error: 'invalid_body'});

  // Checked first so bots calling this URL directly never reach the sheet.
  const recaptcha = verifyRecaptcha(quote.recaptchaToken);
  if (!recaptcha.ok) {
    console.warn('reCAPTCHA rejected: ' + recaptcha.reason);
    return jsonResponse({ok: false, error: 'recaptcha_failed'});
  }

  const problem = validate(quote);
  if (problem) return jsonResponse({ok: false, error: problem});

  // One visitor double-clicking or a bot replaying the same email address.
  const cache = CacheService.getScriptCache();
  const dedupeKey = 'quote:' + quote.email.toLowerCase();
  if (cache.get(dedupeKey)) return jsonResponse({ok: true, duplicate: true});
  cache.put(dedupeKey, '1', 60);

  const lock = LockService.getScriptLock();
  lock.waitLock(20000);
  let leads;
  let row;
  try {
    leads = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(LEADS_SHEET);
    leads.appendRow([
      new Date(),
      cell(quote.firstName), cell(quote.lastName), cell(quote.email), cell(quote.phone),
      cell('$' + quote.homePrice), cell('$' + quote.downPayment), cell('$' + quote.loanAmount),
      cell(quote.creditRange), cell(quote.message || ''), 'pending', recaptcha.score,
    ]);
    row = leads.getLastRow();
  } finally {
    lock.releaseLock();
  }

  // The lead is saved even if the email fails; the status column says why.
  leads.getRange(row, EMAIL_STATUS_COLUMN).setValue(sendLeadEmail(quote));
  return jsonResponse({ok: true});
}

/** Asks Google whether the form's reCAPTCHA token came from a real visitor. */
function verifyRecaptcha(token) {
  if (typeof token !== 'string' || token.length === 0 || token.length > 4000) {
    return {ok: false, reason: 'missing token'};
  }
  const secret = PropertiesService.getScriptProperties().getProperty('RECAPTCHA_SECRET');
  if (!secret) return {ok: false, reason: 'RECAPTCHA_SECRET not set'};
  let result;
  try {
    const response = UrlFetchApp.fetch('https://www.google.com/recaptcha/api/siteverify', {
      method: 'post',
      payload: {secret: secret, response: token},
      muteHttpExceptions: true,
    });
    result = JSON.parse(response.getContentText());
  } catch (error) {
    return {ok: false, reason: 'siteverify failed: ' + error.message};
  }
  if (!result.success) {
    return {ok: false, reason: 'invalid token: ' + (result['error-codes'] || []).join(',')};
  }
  if (result.action !== RECAPTCHA_ACTION) return {ok: false, reason: 'wrong action: ' + result.action};
  if (ALLOWED_HOSTNAMES.indexOf(result.hostname) === -1) {
    return {ok: false, reason: 'wrong hostname: ' + result.hostname};
  }
  if (!(result.score >= RECAPTCHA_MIN_SCORE)) return {ok: false, reason: 'low score: ' + result.score};
  return {ok: true, score: result.score};
}

function sendLeadEmail(quote) {
  const recipients = getRecipients();
  if (recipients.length === 0) return 'not sent: Recipients tab is empty';
  if (MailApp.getRemainingDailyQuota() < recipients.length) {
    return 'not sent: daily email quota reached';
  }
  const name = quote.firstName + ' ' + quote.lastName;
  const rows = [
    ['Name', name],
    ['Email', quote.email],
    ['Phone', quote.phone],
    ['Home price', '$' + quote.homePrice],
    ['Down payment', '$' + quote.downPayment],
    ['Loan amount', '$' + quote.loanAmount],
    ['Credit score range', quote.creditRange],
    ['Message', quote.message || '-'],
  ];
  try {
    MailApp.sendEmail({
      to: recipients.join(','),
      replyTo: quote.email,
      name: 'Simple Mortgage website',
      subject: 'Quick quote request: ' + name,
      body: rows.map((r) => r[0] + ': ' + r[1]).join('\n'),
      htmlBody:
        '<h2>New quick quote request</h2><table cellpadding="6">' +
        rows.map((r) =>
          '<tr><th align="left">' + escapeHtml(r[0]) + '</th><td>' +
          escapeHtml(r[1]).replace(/\n/g, '<br>') + '</td></tr>').join('') +
        '</table>',
    });
    return 'sent to ' + recipients.length;
  } catch (error) {
    return 'not sent: ' + error.message;
  }
}

function getRecipients() {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(RECIPIENTS_SHEET);
  if (!sheet || sheet.getLastRow() < 2) return [];
  return sheet.getRange(2, 1, sheet.getLastRow() - 1, 1).getValues()
    .map((r) => String(r[0]).trim())
    .filter((email) => isEmail(email));
}

/** Mirrors the form's validation so direct POSTs can't store junk. */
function validate(q) {
  const text = (v, min, max) => typeof v === 'string' && v.trim().length >= min && v.length <= max;
  if (!text(q.firstName, 1, 100) || !text(q.lastName, 1, 100)) return 'invalid_name';
  if (!text(q.email, 3, 254) || !isEmail(q.email)) return 'invalid_email';
  if (!text(q.phone, 1, 30) || q.phone.replace(/\D/g, '').length < 10) return 'invalid_phone';
  for (const field of ['homePrice', 'downPayment', 'loanAmount']) {
    if (!text(q[field], 1, 20) || !/^[0-9,.]+$/.test(q[field])) return 'invalid_' + field;
  }
  if (CREDIT_RANGES.indexOf(q.creditRange) === -1) return 'invalid_creditRange';
  if (q.message != null && !text(q.message, 0, 2000)) return 'invalid_message';
  if (q.consent !== true) return 'consent_required';
  return null;
}

function isEmail(value) {
  return /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(value);
}

/** Stops visitor input like "=IMPORTXML(...)" from running as a formula. */
function cell(value) {
  const s = String(value);
  return /^[=+\-@]/.test(s) ? "'" + s : s;
}

function escapeHtml(value) {
  return String(value).replace(/[&<>"']/g, (c) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  })[c]);
}

function jsonResponse(body) {
  return ContentService.createTextOutput(JSON.stringify(body))
    .setMimeType(ContentService.MimeType.JSON);
}
