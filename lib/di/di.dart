import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:base/config/env.dart';
import 'package:base/data/mapper/user_mapper.dart';
import 'package:base/data/repository/master_repository_impl.dart';
import 'package:base/data/repository/source/local/user_local_data_source.dart';
import 'package:base/data/repository/source/remote/api/auth_api.dart';
import 'package:base/data/repository/source/remote/api/middleware/auth_interceptor.dart';
import 'package:base/data/repository/source/remote/api/middleware/basic_auth_interceptor.dart';
import 'package:base/data/repository/source/remote/api/middleware/connectivity_interceptor.dart';
import 'package:base/data/repository/source/remote/api/middleware/refresh_token_interceptor.dart';
import 'package:base/data/repository/source/remote/api/none_auth_api.dart';
import 'package:base/data/repository/source/remote/auth_remote_data_source.dart';
import 'package:base/data/repository/source/remote/master_data_source.dart';
import 'package:base/data/repository/source/auth_repository_impl.dart';
import 'package:base/domain/repository/auth_repository.dart';
import 'package:base/domain/repository/master_repository.dart';
import 'package:base/domain/usecase/get_provinces_usecase.dart';
import 'package:base/domain/usecase/get_skills_usecase.dart';
import 'package:base/domain/usecase/login_usecase.dart';
import 'package:base/domain/usecase/register_usecase.dart';
import 'package:base/domain/usecase/verify_otp_usecase.dart';
import 'package:base/presentation/pages/login/bloc/login_bloc.dart';
import 'package:base/presentation/pages/signup/bloc/signup_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependenceInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(
      getIt<SharedPreferences>(),
      getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton<NoneAuthApi>(() {
    final dio = Dio(BaseOptions(baseUrl: Env.baseUrl));
    dio.interceptors.addAll([
      const ConnectivityInterceptor(),
      AwesomeDioInterceptor(),
    ]);
    return NoneAuthApi(dio);
  });

  getIt.registerLazySingleton<AuthApi>(() {
    final dio = Dio(BaseOptions(baseUrl: Env.baseUrl));
    dio.interceptors.addAll([
      const ConnectivityInterceptor(),
      BasicAuthInterceptor(),
      AuthInterceptor(),
      RefreshTokenInterceptor(
        getIt<UserLocalDataSource>(),
        dio,
      ),
      AwesomeDioInterceptor(),
    ]);
    return AuthApi(dio);
  });

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<NoneAuthApi>()),
  );

  getIt.registerLazySingleton<UserMapper>(() => UserMapper());

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<UserLocalDataSource>(),
      getIt<UserMapper>(),
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory(
    () => LoginCubit(getIt<LoginUseCase>()),
  );

  getIt.registerFactory(
    () => SignupBloc(
      getIt<RegisterUseCase>(),
      getIt<GetSkillsUseCase>(),
      getIt<GetProvincesUseCase>(),
    ),
  );

  // Master data dependencies
  getIt.registerLazySingleton<MasterDataSource>(
    () => MasterDataSourceImpl(getIt<NoneAuthApi>()),
  );

  getIt.registerLazySingleton<MasterRepository>(
    () => MasterRepositoryImpl(getIt<MasterDataSource>()),
  );

  getIt.registerLazySingleton<GetSkillsUseCase>(
    () => GetSkillsUseCase(getIt<MasterRepository>()),
  );

  getIt.registerLazySingleton<GetProvincesUseCase>(
    () => GetProvincesUseCase(getIt<MasterRepository>()),
  );
}
