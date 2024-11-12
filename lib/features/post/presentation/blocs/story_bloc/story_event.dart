part of 'story_bloc.dart';

@freezed
class StoryEvent with _$StoryEvent {
  const factory StoryEvent.started() = _Started;
  const factory StoryEvent.toggleLike(int storyId,
      {@Default(false) bool enforceFavorite}) = _ToggleLike;
}
