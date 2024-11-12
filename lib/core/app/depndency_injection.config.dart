// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:socially/core/app/modules/dio_module.dart' as _i833;
import 'package:socially/core/app/modules/internet_connection_checker_module.dart'
    as _i177;
import 'package:socially/core/app/modules/shared_preferences_module.dart'
    as _i1034;
import 'package:socially/core/cache/app_preferences.dart' as _i454;
import 'package:socially/core/network/general_dio_interceptor.dart' as _i718;
import 'package:socially/core/network/network_info.dart' as _i771;
import 'package:socially/features/post/data/datasource/post_api.dart' as _i126;
import 'package:socially/features/post/data/repository/post_repository_impl.dart'
    as _i501;
import 'package:socially/features/post/domain/repository/post_repository.dart'
    as _i517;
import 'package:socially/features/post/domain/usecase/post_usecase.dart'
    as _i588;
import 'package:socially/features/post/presentation/blocs/comment_bloc/comment_bloc.dart'
    as _i740;
import 'package:socially/features/post/presentation/blocs/post_bloc/post_bloc.dart'
    as _i417;
import 'package:socially/features/post/presentation/blocs/story_bloc/story_bloc.dart'
    as _i641;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final dioModule = _$DioModule();
    final internetConnectionCheckerModule = _$InternetConnectionCheckerModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.connectivity,
      preResolve: true,
    );
    gh.singleton<_i417.PostBloc>(() => _i417.PostBloc());
    gh.singleton<_i641.StoryBloc>(() => _i641.StoryBloc());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i895.Connectivity>(
        () => internetConnectionCheckerModule.connectivity);
    gh.lazySingleton<_i126.PostServiceClient>(
        () => dioModule.providePostServiceClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i454.AppPreferences>(
        () => _i454.AppPreferences(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i771.NetworkInfo>(
        () => _i771.NetworkInfoImplementer(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i517.PostRepository>(() => _i501.PostRepositoryImpl(
          postServiceClient: gh<_i126.PostServiceClient>(),
          networkInfo: gh<_i771.NetworkInfo>(),
        ));
    gh.lazySingleton<_i718.GeneralInterceptor>(
        () => _i718.GeneralInterceptor(gh<_i454.AppPreferences>()));
    gh.lazySingleton<_i588.GetCommentPostUseCase>(() =>
        _i588.GetCommentPostUseCase(repository: gh<_i517.PostRepository>()));
    gh.factory<_i740.CommentBloc>(() => _i740.CommentBloc(
        getCommentPostUseCase: gh<_i588.GetCommentPostUseCase>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i1034.SharedPreferencesModule {}

class _$DioModule extends _i833.DioModule {}

class _$InternetConnectionCheckerModule
    extends _i177.InternetConnectionCheckerModule {}
