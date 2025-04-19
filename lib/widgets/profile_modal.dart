import 'package:flutter/material.dart';

class ProfileModal extends StatelessWidget {
  final String email;
  final String username;
  final Function(bool) onThemeToggle;
  final Function onLogout;  // Add callback for logout

  const ProfileModal({
    Key? key,
    required this.email,
    required this.username,
    required this.onThemeToggle,
    required this.onLogout,  // Add logout function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Your Profile"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.blue,
            child: Text(username.isNotEmpty ? username[0].toUpperCase() : "?"),
          ),
          const SizedBox(height: 10),
          Text(username, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(email, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text("Dark Theme"),
              const Spacer(),
              Switch(
                value: isDark,
                onChanged: (value) {
                  onThemeToggle(value);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Log Out"), // Log out button
          onPressed: () {
            // Logout confirmation dialog
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Do you really want to log out?"),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context), // Close the confirmation dialog
                    ),
                    TextButton(
                      child: const Text("Log Out"),
                      onPressed: () {
                        onLogout();  // Trigger logout callback
                        Navigator.pop(context);  // Close the profile modal
                        Navigator.pop(context);  // Close the confirmation dialog
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
