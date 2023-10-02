import 'package:chat_pusher_laravel/blocs/chat/chat_bloc.dart';
import 'package:chat_pusher_laravel/blocs/user/user_bloc.dart';
import 'package:chat_pusher_laravel/models/models.dart';
import 'package:chat_pusher_laravel/screens/chat/chat_screen.dart';
import 'package:chat_pusher_laravel/screens/chat_list/chat_list_item.dart';
import 'package:chat_pusher_laravel/utils/logger.dart';
import 'package:chat_pusher_laravel/utils/utils.dart';
import 'package:chat_pusher_laravel/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_pusher_laravel/blocs/blocs.dart';
import 'package:chat_pusher_laravel/cubits/cubits.dart';
import 'package:chat_pusher_laravel/screens/guest/guest_screen.dart';
import 'package:search_page/search_page.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  static const routeName = "chat-list";

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final currentUser = authBloc.state.user!;
    final chatBloc = context.read<ChatBloc>();
    final userBloc = context.read<UserBloc>();

    return StartUpContainer(
      onInit: () async {
        chatBloc.add(const ChatStarted());
        userBloc.add(const UserStarted());

        LaravelEcho.init(token: authBloc.state.token!);
      },
      onDisposed: () {
        LaravelEcho.instance.disconnect();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Chat list"),
              Text(
                "User id : ${currentUser.username}",
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          actions: [
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (!state.isAuthenticated) {
                  Navigator.of(context)
                      .pushReplacementNamed(GuestScreen.routeName);
                }
              },
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      context.read<GuestCubit>().signOut();
                    },
                    icon: const Icon(Icons.logout));
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            chatBloc.add(const ChatStarted());
            userBloc.add(const UserStarted());
          },
          child: BlocConsumer<ChatBloc, ChatState>(
            listener: (_, __) {},
            builder: (context, state) {
              if (state.chats.isEmpty) {
                return const BlankContent(
                  content: "No chat available",
                  icon: Icons.chat_rounded,
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  final item = state.chats[index];

                  return ChatListItem(
                    key: ValueKey(item.id),
                    item: item,
                    currentUser: currentUser,
                    onPressed: (chat) {
                      chatBloc.add(ChatSelected(chat));
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(
                  height: 1.5,
                ),
                itemCount: state.chats.length,
              );
            },
          ),
        ),
        floatingActionButton:
            BlocSelector<UserBloc, UserState, List<UserEntity>>(
          selector: (state) {
            return state.map(
              initial: (_) => [],
              loaded: (state) => state.users,
            );
          },
          builder: (context, state) {
            eLog(state);
            return FloatingActionButton(
              onPressed: () => _showSearch(context, state),
              child: const Icon(Icons.search),
            );
          },
        ),
      ),
    );
  }

  void _showSearch(BuildContext context, List<UserEntity> users) {
    showSearch(
      context: context,
      delegate: SearchPage<UserEntity>(
        items: users,
        searchLabel: 'Search people',
        suggestion: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.search,
              size: 25.0,
              color: Colors.grey,
            ),
            Text(
              'Search user by username',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ]),
        ),
        failure: const Center(
          child: Text(
            'No person found :(',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        filter: (user) => [
          user.email,
        ],
        builder: (user) => ListTile(
          leading: const Icon(Icons.account_circle, size: 50.0),
          title: Text(user.username),
          subtitle: Text(user.email),
          onTap: () {
            /// selected user
            context.read<ChatBloc>().add(UserSelected(user));

            /// push to chat screen
            Navigator.of(context).pushNamed(ChatScreen.routeName);
          },
        ),
      ),
    );
  }
}
