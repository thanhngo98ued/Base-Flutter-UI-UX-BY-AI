import 'package:base/di/di.dart';
import 'package:base/presentation/pages/login/bloc/bloc.dart';
import 'package:base/presentation/pages/login/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginFlow {
  LoginFlow._();

  static const String path = '/login';
  static const String name = 'login';

  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginPage(),
          ),
        );
      },
    );
  }
}
