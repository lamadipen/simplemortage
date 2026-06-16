import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/chatbot/mortgage_chatbot_responder.dart';
import 'package:simple_mortgage/features/shared/link_utils.dart';

class MortgageChatbot extends StatefulWidget {
  const MortgageChatbot({super.key});

  @override
  State<MortgageChatbot> createState() => _MortgageChatbotState();
}

class _MortgageChatbotState extends State<MortgageChatbot> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _responder = const MortgageChatbotResponder();
  var _open = false;
  final _messages = <_ChatMessage>[
    const _ChatMessage(
      text:
          'Hi, I’m Simple Mortgage Assistant. Ask me basic questions about FHA, VA, Conventional loans, payments, or pre-approval.',
      fromUser: false,
    ),
  ];

  static const _suggestions = [
    'What is an FHA loan?',
    'How much down payment do I need?',
    'What is PMI?',
    'How do I get pre-approved?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send([String? preset]) {
    final question = (preset ?? _controller.text).trim();
    if (question.isEmpty) return;

    setState(() {
      _messages
        ..add(_ChatMessage(text: question, fromUser: true))
        ..add(_ChatMessage(text: _responder.answer(question), fromUser: false));
      _controller.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 600;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Positioned(
      right: mobile ? 16 : 28,
      bottom: bottomInset > 0 ? bottomInset + 16 : 24,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: _open
            ? _ChatPanel(
                key: const ValueKey('chat-panel'),
                messages: _messages,
                suggestions: _suggestions,
                controller: _controller,
                scrollController: _scrollController,
                onClose: () => setState(() => _open = false),
                onSend: _send,
              )
            : _ChatLauncher(
                key: const ValueKey('chat-launcher'),
                onTap: () => setState(() => _open = true),
              ),
      ),
    );
  }
}

class _ChatLauncher extends StatelessWidget {
  const _ChatLauncher({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open mortgage chat assistant',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFC74446), AppColors.redDark],
            ),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: AppColors.red.withValues(alpha: 0.28),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chat_rounded, color: AppColors.white, size: 22),
              SizedBox(width: 10),
              Text(
                'Ask a question',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatPanel extends StatelessWidget {
  const _ChatPanel({
    super.key,
    required this.messages,
    required this.suggestions,
    required this.controller,
    required this.scrollController,
    required this.onClose,
    required this.onSend,
  });

  final List<_ChatMessage> messages;
  final List<String> suggestions;
  final TextEditingController controller;
  final ScrollController scrollController;
  final VoidCallback onClose;
  final void Function([String? preset]) onSend;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < 600;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: mobile ? width - 32 : 390,
        constraints: BoxConstraints(maxHeight: mobile ? 560 : 620),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.line),
          boxShadow: [
            BoxShadow(
              color: AppColors.navyDark.withValues(alpha: 0.22),
              blurRadius: 32,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ChatHeader(onClose: onClose),
              Flexible(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  children: [
                    for (final message in messages) _MessageBubble(message),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final suggestion in suggestions)
                          ActionChip(
                            label: Text(suggestion),
                            onPressed: () => onSend(suggestion),
                            labelStyle: const TextStyle(
                              color: AppColors.navyDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                            backgroundColor: AppColors.blueLight,
                            side: const BorderSide(color: AppColors.line),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const _ChatHandoffActions(),
              _ChatInput(controller: controller, onSend: onSend),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyDark, AppColors.navy],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFC74446), AppColors.redDark],
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mortgage Assistant',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Basic guidance, not a loan approval',
                  style: TextStyle(color: Color(0xFFD5E1EC), fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            tooltip: 'Close chat',
            icon: const Icon(Icons.close_rounded, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble(this.message);

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final fromUser = message.fromUser;
    return Align(
      alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        constraints: const BoxConstraints(maxWidth: 310),
        decoration: BoxDecoration(
          color: fromUser ? AppColors.red : AppColors.canvas,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(fromUser ? 16 : 4),
            bottomRight: Radius.circular(fromUser ? 4 : 16),
          ),
          border: fromUser ? null : Border.all(color: AppColors.line),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: fromUser ? AppColors.white : AppColors.slate,
            fontSize: 14,
            height: 1.45,
            fontWeight: fromUser ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ChatHandoffActions extends StatelessWidget {
  const _ChatHandoffActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Want a real person to follow up?',
              style: TextStyle(
                color: AppColors.navyDark,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Continue on WhatsApp or call Simple Mortgage LLC directly.',
              style: TextStyle(color: AppColors.slate, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  key: const Key('chatbot-whatsapp-button'),
                  onPressed: () => openLink(AppConstants.whatsappUrl),
                  icon: const Icon(Icons.chat_rounded, size: 18),
                  label: const Text('Chat on WhatsApp'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF128C7E),
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  key: const Key('chatbot-call-button'),
                  onPressed: () => callPhone(AppConstants.mobilePhone),
                  icon: const Icon(Icons.phone_rounded, size: 17),
                  label: const Text('Call Now'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.red,
                    side: const BorderSide(color: AppColors.red),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  const _ChatInput({required this.controller, required this.onSend});

  final TextEditingController controller;
  final void Function([String? preset]) onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              key: const Key('chatbot-question-input'),
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: const InputDecoration(
                hintText: 'Ask about loans, PMI, rates...',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton.filled(
            onPressed: () => onSend(),
            tooltip: 'Send message',
            style: IconButton.styleFrom(backgroundColor: AppColors.red),
            icon: const Icon(Icons.send_rounded, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({required this.text, required this.fromUser});

  final String text;
  final bool fromUser;
}
