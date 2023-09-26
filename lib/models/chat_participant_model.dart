import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chat_pusher_laravel/models/user_model.dart';


part 'chat_participant_model.freezed.dart';
part 'chat_participant_model.g.dart';

@freezed
class ChatParticipantEntity with _$ChatParticipantEntity {
  factory ChatParticipantEntity({
    required int id,
    @JsonKey(name : "chat_id") required int chatId,
    required int userId,
    required UserEntity user,
  }) = _ChatParticipantEntity;
	
  factory ChatParticipantEntity.fromJson(Map<String, dynamic> json) =>
			_$ChatParticipantEntityFromJson(json);
}
