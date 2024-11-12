import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:socially/core/app/depndency_injection.config.dart';

final getIt = GetIt.instance;
@injectableInit
Future<void> configureInjection() async {
  getIt.init();
}