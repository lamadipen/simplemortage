# Simple Mortgage LLC

A responsive Flutter web experience for Simple Mortgage LLC, built with
Material 3 and optimized for mobile, tablet, and desktop.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Build

```bash
flutter build web --release
```

The production output is written to `build/web`.

## Deploy to Firebase Hosting

1. Install and authenticate the Firebase CLI:

   ```bash
   npm install -g firebase-tools
   firebase login
   ```

2. Associate the directory with the correct Firebase project:

   ```bash
   firebase use --add
   ```

3. Build and deploy:

   ```bash
   flutter build web --release
   firebase deploy --only hosting
   ```

`firebase.json` includes the single-page app rewrite and static asset caching.

## Quote form integration

The quote form currently uses `MockQuoteSubmissionService`. Implement
`QuoteSubmissionService` with a server-side endpoint, Firebase Function,
email service, CRM, or LendingPad integration. Keep credentials and API keys
off the Flutter frontend.
