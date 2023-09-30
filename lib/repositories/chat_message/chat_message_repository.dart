import 'package:chat_pusher_laravel/models/app_response.dart';
import 'package:chat_pusher_laravel/models/chat_message_model.dart';
import 'package:chat_pusher_laravel/models/requests/create_chat_message_request.dart';
import 'package:chat_pusher_laravel/repositories/chat_message/base_chat_message_repository.dart';
import 'package:chat_pusher_laravel/repositories/core/endpoints.dart';
import 'package:chat_pusher_laravel/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';

class ChatMessageRepository extends BaseChatMessageRepository {
  final Dio _dioClient;

  ChatMessageRepository({
    Dio? dioClient,
  }) : _dioClient = dioClient ?? DioClient().instance;

  @override
  Future<AppResponse<ChatMessageEntity?>> createChatMessage(
      CreateChatMessageRequest request) async {
    final response = await _dioClient.post(
      Endpoints.createChatMessage,
      data: request.toJson(),
    );

    return AppResponse<ChatMessageEntity?>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatMessageEntity.fromJson(json)
          : null,
    );
  }

  @override
  Future<AppResponse<List<ChatMessageEntity>>> getChatMessages({
    required int chatId,
    required int page
  }) async {
    final response = await _dioClient.get(
      Endpoints.getChatMessages,
      queryParameters: {
        'page': page,
        'chat_id': chatId,
      },
    );

    return AppResponse<List<ChatMessageEntity>>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? (json as List<dynamic>)
              .map((e) => ChatMessageEntity.fromJson(e))
              .toList()
          : [],
    );
  }
}
