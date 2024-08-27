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
      appBar: AppBar(
        title: const Text('Virtual Ancestral Dialogue'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('How to Use Virtual Ancestral Dialogue'),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Here are some ways to interact effectively:'),
                          Text('• Ask for deep cultural dives into any African tribe'),
                          Text('• Request proverbs and origin stories'),
                          Text('• Inquire about migratory patterns of African peoples'),
                          Text('• Ask for book recommendations on African history and culture'),
                          Text('• Explore future projections for African peoples and cultures'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
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
                  child: Tooltip(
                    message: 'Ask about African cultures, stories, history, or future projections',
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                      ),
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
