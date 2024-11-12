import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:socially/features/post/domain/models/comment_model/comment_model.dart';
import 'package:socially/features/post/domain/usecase/post_usecase.dart';

part 'comment_bloc.freezed.dart';
part 'comment_event.dart';
part 'comment_state.dart';

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc({required this.getCommentPostUseCase})
      : super(const CommentState.loading()) {
    on<CommentEvent>((event, emit) async {
      await event.map(
        getComments: (value) async {
          emit(const CommentState.loading());
          final failureOrComments =
              await getCommentPostUseCase.execute((postId: value.postId));
          failureOrComments.when(
            (success) {
              emit(CommentState.loaded(comments: success));
            },
            (error) {
              emit(CommentState.error(message: error.message));
            },
          );
        },
      );
    });
  }
  final GetCommentPostUseCase getCommentPostUseCase;
}
