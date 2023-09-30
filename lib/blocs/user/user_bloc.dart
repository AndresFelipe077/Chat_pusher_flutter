import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chat_pusher_laravel/models/models.dart';
import 'package:chat_pusher_laravel/repositories/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const Initial()) {
    on<UserEvent>((event, emit) async {
      final result = await _userRepository.getUsers();
      emit(Loaded(result.data ?? []));
    });
  }
}
