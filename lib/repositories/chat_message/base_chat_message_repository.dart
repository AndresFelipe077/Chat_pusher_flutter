import 'package:chat_pusher_laravel/models/models.dart';
import 'package:chat_pusher_laravel/models/requests/requests.dart';

abstract class BaseChatMessageRepository {
  Future<AppResponse<List<ChatMessageEntity>>> getChatMessages({
    required int chatId,
    required int page,
  });

  Future<AppResponse<ChatMessageEntity?>> createChatMessage(
    CreateChatMessageRequest request.
    String sockedId,
  );
}
