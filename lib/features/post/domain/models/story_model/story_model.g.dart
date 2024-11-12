// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryModelImpl _$$StoryModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryModelImpl(
      id: (json['id'] as num).toInt(),
      userImage: json['userImage'] as String,
      elapsedTime: DateTime.parse(json['elapsedTime'] as String),
      imageUrl: json['imageUrl'] as String,
      tag: json['tag'] as String,
      userName: json['userName'] as String,
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$$StoryModelImplToJson(_$StoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userImage': instance.userImage,
      'elapsedTime': instance.elapsedTime.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'tag': instance.tag,
      'userName': instance.userName,
      'isLiked': instance.isLiked,
    };
