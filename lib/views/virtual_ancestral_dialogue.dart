import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/ancestral_dialogue_controller.dart';

class VirtualAncestralDialogue extends ConsumerStatefulWidget {
  const VirtualAncestralDialogue({super.key});

  @override
  ConsumerState<VirtualAncestralDialogue> createState() =>
      _VirtualAncestralDialogueState();
}

class _VirtualAncestralDialogueState
    extends ConsumerState<VirtualAncestralDialogue> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(ancestralDialogueProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Ancestral Dialogue')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: MarkdownBody(
                    data: message.content,
                  ),
                  leading: CircleAvatar(
                    child: Text(message.role[0].toUpperCase()),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      ref
                          .read(ancestralDialogueProvider.notifier)
                          .sendMessage(_messageController.text);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
