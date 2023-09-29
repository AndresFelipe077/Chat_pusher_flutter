import 'package:chat_pusher_laravel/blocs/chat/chat_bloc.dart';
import 'package:chat_pusher_laravel/models/models.dart';
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

    return StartUpContainer(
      onInit: () async {
        chatBloc.add(const ChatStarted());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Chat list"),
              Text(
                "User id : ${currentUser}",
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
        body: BlocConsumer<ChatBloc, ChatState>(
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
                return const Text("Hello");
              },
              separatorBuilder: (_, __) => const Divider(
                height: 1.5,
              ),
              itemCount: state.chats.length,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSearch(
                context: context,
                delegate: SearchPage<UserEntity>(
                    items: [],
                    searchLabel: 'Search people',
                    suggestion: const Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                          onTap: () {},
                        )));
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
