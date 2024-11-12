import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:socially/core/app/modules/dio_module.dart';
import 'package:socially/core/cache/app_preferences.dart';

@lazySingleton
class GeneralInterceptor extends Interceptor {
  GeneralInterceptor(this.appPreferences);
  final AppPreferences appPreferences;
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String language = await appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: await appPreferences.getUserToken(),
      DEFAULT_LANGUAGE: language,
    };
    options.headers.addAll(headers);
    log(options.toString());
    super.onRequest(options, handler);
  }
}
