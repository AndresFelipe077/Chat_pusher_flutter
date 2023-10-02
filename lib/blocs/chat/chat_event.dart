part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.started() = ChatStarted;
  const factory ChatEvent.reset({bool? shouldResetChat}) = ChatReset;
  const factory ChatEvent.userSeleted(UserEntity user) = UserSelected;
  const factory ChatEvent.getChatMessage() = GetChatMessage;
  const factory ChatEvent.loadMoreChatMessage() = LoadMoreChatMessage;
  const factory ChatEvent.sendMessages(
    int chatId,
    ChatMessage message, {
      required String sockedId
    }
  ) = SendMessage;
  const factory ChatEvent.chatSelected(ChatEntity chat) = ChatSelected;
  const factory ChatEvent.addNewMessage(ChatMessageEntity message) =
      AddNewMessage;
}
