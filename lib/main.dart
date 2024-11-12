import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socially/core/app/app.dart';
import 'package:socially/core/app/bloc_observer.dart';
import 'package:socially/core/app/depndency_injection.dart';
import 'package:socially/core/localization/language_manager.dart';
import 'package:socially/features/post/domain/models/comment_model/comment_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  EasyLocalization.logger.enableBuildModes = [];
  await configureInjection();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();

  Hive.registerAdapter(CommentModelAdapter());
  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: ASSETS_PATH_LOCALIZATION,
      child: const MyApp(),
    ),
  );
}
