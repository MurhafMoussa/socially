import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:socially/core/constants/assets_manager.dart';
import 'package:socially/features/post/domain/models/post_model/post_model.dart';

part 'post_bloc.freezed.dart';
part 'post_event.dart';
part 'post_state.dart';

@singleton
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const _Initial()) {
    on<PostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  List<PostModel> posts = [
    PostModel(
      id: 1,
      imageUser: ImageAssets.person2,
      name: 'Kylie Jenner',
      post:
          'Stopped by @zoesugg today with goosey girl to see @kyliecosmetics & @kylieskin 💕 wow what a dream!!!!!!!! It’s the best experience we have!',
      time: '2d ago',
      tagName: 'Zoe Sugg',
      likesCount: 1320,
      commentsCount: 23,
    ),
    PostModel(
      id: 2,
      imageUser: ImageAssets.person5,
      name: 'Alex Strohl',
      post:
          'This is one of the best experiences that I’ve ever had in my life! the mountain view here is emazing.',
      time: '1w ago',
      tags: ['Alberta', 'Cold', 'Meditation'],
      images: [ImageAssets.postImg1],
      likesCount: 1320,
      commentsCount: 23,
    ),
    PostModel(
      id: 3,
      imageUser: ImageAssets.person7,
      name: 'Andre Alexander',
      time: '2h ago',
      images: [
        ImageAssets.postImg2_1,
        ImageAssets.postImg2_2,
        ImageAssets.postImg2_3,
      ],
      likesCount: 1320,
      commentsCount: 23,
    ),
  ];
}
