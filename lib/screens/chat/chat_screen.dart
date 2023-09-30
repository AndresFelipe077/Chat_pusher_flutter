import 'package:chat_pusher_laravel/blocs/chat/chat_bloc.dart';
import 'package:chat_pusher_laravel/utils/logger.dart';
import 'package:chat_pusher_laravel/widgets/startup_container.dart';
import 'package:flutter/material.dart';
import 'package:chat_pusher_laravel/screens/chat/data.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_pusher_laravel/widgets/widgets.dart';
// import 'package:pusher_client/pusher_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const routeName = "chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = basicSample;

  @override
  Widget build(BuildContext context) {
    return StartUpContainer(
      onInit: (){
        /// Create a chat and get chat messages
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocConsumer<ChatBloc, ChatState>(
            listener: (_, __) {},
            builder: (context, state) {
              final chat = state.selectChat;
              vLog(chat);
              return Text("Other user name");
            },
          ),
        ),
        body: DashChat(
          currentUser: user,
          onSend: (ChatMessage chatMessage) {
            vLog("add new message to message");
          },
          messages: messages,
          messageListOptions: MessageListOptions(
            onLoadEarlier: () async {
              await Future.delayed(const Duration(seconds: 3));
    
              /// Load more messages
            },
          ),
        ),
      ),
    );
  }
}
