import 'package:chat_pusher_laravel/models/app_response.dart';
import 'package:chat_pusher_laravel/models/requests/login_request.dart';
import 'package:chat_pusher_laravel/models/requests/register_request.dart';
import 'package:chat_pusher_laravel/models/user_model.dart';
import 'package:chat_pusher_laravel/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository{
  @override
  Future<AppResponse<AuthUser>> login(LoginRequest request) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AppResponse<UserEntity>> loginWithToken() {
    // TODO: implement loginWithToken
    throw UnimplementedError();
  }

  @override
  Future<AppResponse> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AppResponse<AuthUser>> register(RegisterRequest request) {
    // TODO: implement register
    throw UnimplementedError();
  }

}