import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/ancestral_dialogue_controller.dart';
import '../widgets/kemet_app_bar.dart';
import '../widgets/kemet_title.dart';
import '../widgets/kemet_body_text.dart';

class VirtualAncestralDialogue extends ConsumerStatefulWidget {
  const VirtualAncestralDialogue({super.key});

  @override
  ConsumerState<VirtualAncestralDialogue> createState() =>
      _VirtualAncestralDialogueState();
}

class _VirtualAncestralDialogueState
    extends ConsumerState<VirtualAncestralDialogue>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(ancestralDialogueProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: KemetAppBar(
        title: 'Virtual Ancestral Dialogue',
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ancestral.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: message.role == 'user'
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (message.role != 'user')
                              CircleAvatar(
                                backgroundColor:
                                    Colors.deepPurple.withOpacity(0.7),
                                child: KemetTitle(
                                  text: message.role[0].toUpperCase(),
                                  fontSize: 16,
                                  color: Colors.white,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: MarkdownBody(
                                    data: message.content,
                                    styleSheet: MarkdownStyleSheet(
                                      p: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (message.role == 'user')
                              const SizedBox(width: 8),
                            if (message.role == 'user')
                              CircleAvatar(
                                backgroundColor:
                                    Colors.deepPurple.withOpacity(0.7),
                                child: KemetTitle(
                                  text: message.role[0].toUpperCase(),
                                  fontSize: 16,
                                  color: Colors.white,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: GoogleFonts.lato(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          style: GoogleFonts.lato(color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.deepPurple),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            ref
                                .read(ancestralDialogueProvider.notifier)
                                .sendMessage(_messageController.text);
                            _messageController.clear();
                            _animationController.reset();
                            _animationController.forward();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const KemetTitle(
            text: 'How to Use',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                KemetBodyText(text: 'Here are some ways to interact effectively:'),
                KemetBodyText(text: '• Ask about any African tribe'),
                KemetBodyText(text: '• Request proverbs and stories'),
                KemetBodyText(text: '• Inquire about migrations'),
                KemetBodyText(text: '• Ask for book recommendations'),
                KemetBodyText(text: '• Explore future projections'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const KemetBodyText(text: 'Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
