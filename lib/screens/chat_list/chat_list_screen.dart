import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  static const routeName = "chat-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat List"),
        actions: [
          IconButton(
              onPressed: () {
                print('logout');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
