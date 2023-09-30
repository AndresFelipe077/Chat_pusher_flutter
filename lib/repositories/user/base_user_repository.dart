import 'package:chat_pusher_laravel/models/app_response.dart';
import 'package:chat_pusher_laravel/models/user_model.dart';

abstract class BaseUserRepository {
  Future<AppResponse<List<UserEntity>>> getUsers();
}
