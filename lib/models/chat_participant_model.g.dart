// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatParticipantEntity _$$_ChatParticipantEntityFromJson(
        Map<String, dynamic> json) =>
    _$_ChatParticipantEntity(
      id: json['id'] as int,
      chatId: json['chat_id'] as int,
      userId: json['userId'] as int,
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ChatParticipantEntityToJson(
        _$_ChatParticipantEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'userId': instance.userId,
      'user': instance.user,
    };
