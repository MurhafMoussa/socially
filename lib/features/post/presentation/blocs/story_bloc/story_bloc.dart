import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:socially/core/constants/assets_manager.dart';
import 'package:socially/features/post/domain/models/story_model/story_model.dart';

part 'story_bloc.freezed.dart';
part 'story_event.dart';
part 'story_state.dart';

@singleton
class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryState(_initialStories)) {
    on<StoryEvent>((event, emit) {
      event.map(
        started: (event) => {},
        toggleLike: (event) => _onToggleLike(event, emit),
      );
    });
  }

  List<StoryModel> get initialStories => _initialStories;

  void _onToggleLike(_ToggleLike event, Emitter<StoryState> emit) {
    final updatedStories = List<StoryModel>.from(state.stories);
    final index =
        updatedStories.indexWhere((story) => story.id == event.storyId);

    if (index != -1) {
      final story = updatedStories[index];
      updatedStories[index] = story.copyWith(
          isLiked: event.enforceFavorite ? true : !story.isLiked);
      emit(StoryState(updatedStories));
    }
  }
}

List<StoryModel> _initialStories = [
  StoryModel(
    userImage: ImageAssets.person1,
    elapsedTime: DateTime.now().subtract(const Duration(minutes: 17)),
    imageUrl:
        'https://s3-alpha-sig.figma.com/img/459e/873d/2899a30a1e54467a54d709ef9349c328?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dou7elYfefOti-G6fSauWjPtWZiGSWhLgJiLlnV5xEQ6RCZAcpmZ-q45cCv-okVpyz2qOBTuGuz36pJDlFGgxVoKdZJBXFRgr5ZYb27SCn~0do2-yfbo-PTdUh1T8EeQbJlO0gOch9u-kKZoHJFD8WSFR9O6EjiI~beUabTwmQXI1nBYbb-3PuD467-wmcNi3KxE27oxVdnFUgYGiKAP5Ji71V~Jxpa6GogkRkg8SNDVCaPLAQ5S7qZi1ew74JfcyqgJEVjqUl9UDLpoTI2ieOGRZAdBx57~-U6AtTVlvSrvmGnxqDbvyMQ7ocBQ3phfeLQn4hZDhjIwwOpn9AVaZg__',
    tag: 'Funny',
    userName: 'AlexMorgan',
    id: 0,
  ),
  StoryModel(
    userImage: ImageAssets.person2,
    elapsedTime: DateTime.now().subtract(const Duration(hours: 1)),
    imageUrl:
        'https://s3-alpha-sig.figma.com/img/cb11/4bbb/74aebe16a4ba91205ed6da4f5038fc96?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=H7nK4eG5xbrf5zKxlOTnTqlY12EKbIUgpJHjKfIFpoIFOWYn1sNzODjK9cY5K9u65UcIcXp~3TTI1OsquWGFmE8WiytO1TqPldrRJUsY8-GxoA2FWLPXM8XedQJFFprgo-IVE659cAmDcrgkLjkxgdhssK6UJ8QObVYZlhY7h6FfNY-PUlCH6h4bRovxP3q0WgdaLWqstSzzq7bdOath-uaCeUSGuUw6k1hCJCLQe-VQyYtbBNndQkrRSA9dzvMWeUnRCPFZ-r2eiaqTV4Ivhgq2MpVyL40-IKkXcEWwyPkDej2OLgVjf6lg4jjUt5AGcoxfU0EfX4AHmdfP-ICXzw__',
    tag: 'Adventure',
    userName: 'JamieHunt',
    id: 1,
  ),
  StoryModel(
    userImage: ImageAssets.person3,
    elapsedTime: DateTime.now().subtract(const Duration(hours: 5)),
    imageUrl:
        'https://s3-alpha-sig.figma.com/img/f12c/cfc5/ba54a0926b720ae70cffa6cc4b1ac6df?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=N3fTtuOmLmZHj1Nlg03Yeyd62M2F9mXAfHnBw7eU0xvBMkDjql1t2LNCpoW54CJ5aZm1oZf0ty2pTndHeTr99nuVuuKl-BcieoDzRIWOhGG46tt7gs5ax6cIb2RsjYdEzwN0xFLwji5Fl9IHQ7DPtmZdFprn3xGVGCzg7VE6QwTSxAodk0xVsUES3NaK~luO8A29XIkvDfchJr-gYYATYfnQJS54MG5dOzBjTwxOgQuiPjQZdZ99iJqsX97KBk9XYP~5~hkVK4A~~sdrsFHTruOQKGCphVq2Ap5i9e1Jzxo~hxw5MwwF7~kIhw5VeXMDisCYYhdU~EJ-BqHHdhLP8A__',
    tag: 'Inspiration',
    userName: 'TaylorSmith',
    id: 2,
  ),
  StoryModel(
    userImage: ImageAssets.person4,
    elapsedTime: DateTime.now().subtract(const Duration(days: 1)),
    imageUrl:
        'https://s3-alpha-sig.figma.com/img/459e/873d/2899a30a1e54467a54d709ef9349c328?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dou7elYfefOti-G6fSauWjPtWZiGSWhLgJiLlnV5xEQ6RCZAcpmZ-q45cCv-okVpyz2qOBTuGuz36pJDlFGgxVoKdZJBXFRgr5ZYb27SCn~0do2-yfbo-PTdUh1T8EeQbJlO0gOch9u-kKZoHJFD8WSFR9O6EjiI~beUabTwmQXI1nBYbb-3PuD467-wmcNi3KxE27oxVdnFUgYGiKAP5Ji71V~Jxpa6GogkRkg8SNDVCaPLAQ5S7qZi1ew74JfcyqgJEVjqUl9UDLpoTI2ieOGRZAdBx57~-U6AtTVlvSrvmGnxqDbvyMQ7ocBQ3phfeLQn4hZDhjIwwOpn9AVaZg__',
    tag: 'Travel',
    userName: 'JordanLee',
    id: 3,
  ),
  StoryModel(
    userImage: ImageAssets.person5,
    elapsedTime: DateTime.now().subtract(const Duration(days: 3)),
    imageUrl:
        'https://s3-alpha-sig.figma.com/img/cb11/4bbb/74aebe16a4ba91205ed6da4f5038fc96?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=H7nK4eG5xbrf5zKxlOTnTqlY12EKbIUgpJHjKfIFpoIFOWYn1sNzODjK9cY5K9u65UcIcXp~3TTI1OsquWGFmE8WiytO1TqPldrRJUsY8-GxoA2FWLPXM8XedQJFFprgo-IVE659cAmDcrgkLjkxgdhssK6UJ8QObVYZlhY7h6FfNY-PUlCH6h4bRovxP3q0WgdaLWqstSzzq7bdOath-uaCeUSGuUw6k1hCJCLQe-VQyYtbBNndQkrRSA9dzvMWeUnRCPFZ-r2eiaqTV4Ivhgq2MpVyL40-IKkXcEWwyPkDej2OLgVjf6lg4jjUt5AGcoxfU0EfX4AHmdfP-ICXzw__',
    tag: 'Food',
    userName: 'RileyAnderson',
    id: 4,
  ),
  StoryModel(
    userImage: ImageAssets.person6,
    elapsedTime: DateTime.now().subtract(const Duration(days: 7)),
    imageUrl:
        'https://s3-alpha-sig.figma.com/img/f12c/cfc5/ba54a0926b720ae70cffa6cc4b1ac6df?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=N3fTtuOmLmZHj1Nlg03Yeyd62M2F9mXAfHnBw7eU0xvBMkDjql1t2LNCpoW54CJ5aZm1oZf0ty2pTndHeTr99nuVuuKl-BcieoDzRIWOhGG46tt7gs5ax6cIb2RsjYdEzwN0xFLwji5Fl9IHQ7DPtmZdFprn3xGVGCzg7VE6QwTSxAodk0xVsUES3NaK~luO8A29XIkvDfchJr-gYYATYfnQJS54MG5dOzBjTwxOgQuiPjQZdZ99iJqsX97KBk9XYP~5~hkVK4A~~sdrsFHTruOQKGCphVq2Ap5i9e1Jzxo~hxw5MwwF7~kIhw5VeXMDisCYYhdU~EJ-BqHHdhLP8A__',
    tag: 'Lifestyle',
    userName: 'Mario',
    id: 5,
  ),
  StoryModel(
    userImage: ImageAssets.person7,
    elapsedTime: DateTime.now().subtract(const Duration(days: 30)),
    imageUrl:
        'https://s3-alpha-sig.figma.com/img/459e/873d/2899a30a1e54467a54d709ef9349c328?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dou7elYfefOti-G6fSauWjPtWZiGSWhLgJiLlnV5xEQ6RCZAcpmZ-q45cCv-okVpyz2qOBTuGuz36pJDlFGgxVoKdZJBXFRgr5ZYb27SCn~0do2-yfbo-PTdUh1T8EeQbJlO0gOch9u-kKZoHJFD8WSFR9O6EjiI~beUabTwmQXI1nBYbb-3PuD467-wmcNi3KxE27oxVdnFUgYGiKAP5Ji71V~Jxpa6GogkRkg8SNDVCaPLAQ5S7qZi1ew74JfcyqgJEVjqUl9UDLpoTI2ieOGRZAdBx57~-U6AtTVlvSrvmGnxqDbvyMQ7ocBQ3phfeLQn4hZDhjIwwOpn9AVaZg__',
    tag: 'Throwback',
    userName: 'Lola',
    id: 6,
  ),
];
