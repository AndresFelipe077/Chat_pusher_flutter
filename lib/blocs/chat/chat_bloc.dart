import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_pusher_laravel/enums/enums.dart';
import 'package:chat_pusher_laravel/models/models.dart';
import 'package:chat_pusher_laravel/repositories/chat/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(ChatState.initial()) {
    on<ChatStarted>((event, emit) async {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: DataStatus.loading));

      final result = await _chatRepository.getChats();

      emit(state.copyWith(
        status: DataStatus.loaded,
        chats: result.success ? result.data ?? [] : [],
      ));
    });

    on<ChatReset>((event, emit) {
      emit(ChatState.initial());
    });

    on<UserSelected>((event, emit) {
      emit(state.copyWith(
        otherUserId: event.user.id,
      ));
    });
  }
}
