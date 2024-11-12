part of 'story_bloc.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState(List<StoryModel> stories) = _StoryState;
}
