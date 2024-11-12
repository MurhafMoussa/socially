import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/src/result.dart';
import 'package:socially/core/bases/models/failure_model/failure_model.dart';
import 'package:socially/core/constants/string_manager.dart';
import 'package:socially/core/network/network_info.dart';
import 'package:socially/features/post/data/datasource/post_api.dart';
import 'package:socially/features/post/domain/models/comment_model/comment_model.dart';
import 'package:socially/features/post/domain/repository/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl({
    required this.postServiceClient,
    required this.networkInfo,
  });

  final PostServiceClient postServiceClient;
  final NetworkInfo networkInfo;

  // Hive box name for storing comments
  final String _commentsBoxName = 'commentsBox';

  @override
  Future<Result<List<CommentModel>, FailureModel>> getComments({
    required int postId,
  }) async {
    // Check if the device is connected to the internet
    if (await networkInfo.isConnected) {
      try {
        // Fetch comments from the API
        final response = await postServiceClient.getComments(postId: postId);
        if (response.response.statusCode == 200) {
          // On successful fetch, save comments to Hive for offline access
          await _saveCommentsToHive(postId, response.data);
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        log(e.stackTrace.toString());
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      // If offline, attempt to load comments from Hive
      final cachedComments = await _getCommentsFromHive(postId);
      if (cachedComments.isNotEmpty) {
        return Success(cachedComments);
      } else {
        return Error(FailureModel(message: AppStrings().checkInternet));
      }
    }
  }

  // Save comments to Hive
  Future<void> _saveCommentsToHive(
      int postId, List<CommentModel> comments) async {
    final box = await Hive.openBox<List<CommentModel>>(_commentsBoxName);
    await box.put(postId.toString(), comments);
    await box.close();
  }

  // Retrieve comments from Hive by postId
  Future<List<CommentModel>> _getCommentsFromHive(int postId) async {
    final box = await Hive.openBox<List<dynamic>>(_commentsBoxName);
    final cachedComments =
        List<CommentModel>.from(box.get(postId.toString()) ?? []);
    await box.close();
    return cachedComments;
  }
}
