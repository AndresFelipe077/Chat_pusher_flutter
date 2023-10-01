import 'package:chat_pusher_laravel/blocs/auth/auth_bloc.dart';
import 'package:chat_pusher_laravel/blocs/chat/chat_bloc.dart';
import 'package:chat_pusher_laravel/utils/chat.dart';
import 'package:chat_pusher_laravel/utils/logger.dart';
import 'package:chat_pusher_laravel/widgets/startup_container.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    final authBloc = context.read<AuthBloc>();

    return StartUpContainer(
      onInit: () {
        /// Create a chat and get chat messages
        chatBloc.add(const GetChatMessage());
      },
      onDisposed: () {
        chatBloc.add(const ChatReset());
        chatBloc.add(const ChatStarted());
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocConsumer<ChatBloc, ChatState>(
            listener: (_, __) {},
            builder: (context, state) {
              final chat = state.selectedChat;
              vLog(chat);
              return Text(chat == null
                  ? "N/A"
                  : getChatName(chat.participants, authBloc.state.user!));
            },
          ),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            vLog(state.chatMessages);
            return DashChat(
              currentUser: authBloc.state.user!.toChatUser,
              onSend: (ChatMessage chatMessage) {
                chatBloc.add(SendMessage(state.selectedChat!.id, chatMessage));
              },
              messages: state.uiChatMessages,
              messageListOptions: MessageListOptions(
                onLoadEarlier: () async {
                  chatBloc.add(const LoadMoreChatMessage());

                  /// Load more messages
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
