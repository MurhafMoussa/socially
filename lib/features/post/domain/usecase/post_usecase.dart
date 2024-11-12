import 'package:injectable/injectable.dart';
import 'package:multiple_result/src/result.dart';
import 'package:socially/core/bases/models/failure_model/failure_model.dart';
import 'package:socially/core/bases/usecases/base_usecase.dart';
import 'package:socially/features/post/domain/models/comment_model/comment_model.dart';
import 'package:socially/features/post/domain/repository/post_repository.dart';

@lazySingleton
class GetCommentPostUseCase
    implements BaseUseCase<({int postId}), List<CommentModel>> {
  GetCommentPostUseCase({required this.repository});
  final PostRepository repository;
  @override
  Future<Result<List<CommentModel>, FailureModel>> execute(
    ({int postId}) input,
  ) {
    return repository.getComments(postId: input.postId);
  }
}
