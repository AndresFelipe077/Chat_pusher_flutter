part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    required List<ChatEntity> chats,
    required List<ChatMessageEntity> chatMessages,
    ChatEntity? selectChat,
    required DataStatus status,
    required String message,
    int? otherUserId,
    required bool isLastPage,
    required int page,
  }) = _ChatState;

  factory ChatState.initial() {
    return const ChatState(
        chats: [],
        selectChat: null,
        status: DataStatus.initial,
        message: "",
        otherUserId: null,
        chatMessages: [],
        isLastPage: false,
        page: 1
    );
  }
}
