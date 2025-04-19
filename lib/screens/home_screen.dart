import 'package:flutter/material.dart';
import 'package:talkie_tool/widgets/chat_input_bar.dart';
import 'package:talkie_tool/widgets/chat_bubble.dart';
import 'package:talkie_tool/widgets/profile_modal.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, String> user;
  final Function(bool) onThemeChange;
  final Function onLogout;

  const HomeScreen({
    Key? key,
    required this.user,
    required this.onThemeChange,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> messages = [
    {"role": "bot", "text": "Hi there! How can I help you prepare today?"}
  ];

  void _handleSend(String text) {
    setState(() {
      messages.add({"role": "user", "text": text});
      messages.add({"role": "bot", "text": "This is a refined response (placeholder)."});
    });
  }

  void _newChat() {
    setState(() {
      messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loggedIn = widget.user.isNotEmpty;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text("Previous Chats", style: TextStyle(fontSize: 20))),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("New Chat"),
              onTap: () {
                Navigator.pop(context);
                _newChat();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Talkie Tool"),
        actions: [
          loggedIn
              ? IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => ProfileModal(
                email: widget.user['email'] ?? '', // Safe fallback
                username: widget.user['username'] ?? '', // Safe fallback
                onThemeToggle: widget.onThemeChange,
                onLogout: widget.onLogout,
              ),
            ),
          )
              : Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final msg = messages[index];
                return ChatBubble(text: msg['text']!, isUser: msg['role'] == 'user');
              },
            ),
          ),
          const Divider(height: 1),
          ChatInputBar(onSend: _handleSend),
          if (!loggedIn)
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text("Guest mode enabled", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
        ],
      ),
    );
  }
}
