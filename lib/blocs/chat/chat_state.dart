part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    required List<ChatEntity> chats,
    ChatEntity? selectChat,
    required DataStatus status,
    required String message,
    int? otherUserId,
  }) = _ChatState;

  factory ChatState.initial() {
    return const ChatState(
        chats: [],
        selectChat: null,
        status: DataStatus.initial,
        message: "",
        otherUserId: null
    );
  }
}
