import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  final Function(String) onSend;

  const ChatInputBar({Key? key, required this.onSend}) : super(key: key);

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _canSend = false;

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
      setState(() => _canSend = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _canSend = _controller.text.trim().isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSend(),
                decoration: InputDecoration(
                  hintText: "Ask something or start a conversation...",
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 24,
              backgroundColor: _canSend
                  ? theme.colorScheme.primary
                  : Colors.grey.shade400,
              child: IconButton(
                icon: Icon(Icons.send,
                    color: _canSend ? Colors.white : Colors.black26),
                onPressed: _canSend ? _handleSend : null,
                tooltip: "Send",
              ),
            ),
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade200,
              child: IconButton(
                icon: const Icon(Icons.mic, color: Colors.black54),
                onPressed: () {
                  // TODO: Add voice functionality later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Voice input coming soon!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                tooltip: "Voice Input",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
