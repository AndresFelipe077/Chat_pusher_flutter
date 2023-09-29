import 'package:chat_pusher_laravel/blocs/auth/auth_bloc.dart';
import 'package:chat_pusher_laravel/cubits/cubits.dart';
import 'package:chat_pusher_laravel/screens/guest/guest_screen.dart';
import 'package:chat_pusher_laravel/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  static const routeName = "chat-list";

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    eLog(authState);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat List"),
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
    );
  }
}
