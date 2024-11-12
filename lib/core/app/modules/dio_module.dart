import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:socially/features/post/data/datasource/post_api.dart';

import '../../constants/constants.dart';
import '../../network/general_dio_interceptor.dart';
import '../depndency_injection.dart';

const String APPLICATION_JSON = 'application/json';
const String MULTIPART_JSON = 'multipart/form-data';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'login-token';
const String DEFAULT_LANGUAGE = 'lang';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    Dio client = Dio();
    Duration timeOut = const Duration(minutes: 5);

    client.options = BaseOptions(
      baseUrl: Constant.DOMAIN,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
    );
    client.interceptors.add(getIt<GeneralInterceptor>());
    if (kReleaseMode) {
    } else {
      client.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
    return client;
  }

  @lazySingleton
  PostServiceClient providePostServiceClient(Dio dio) => PostServiceClient(dio);
}
