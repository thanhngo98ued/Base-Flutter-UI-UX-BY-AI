import 'package:base/di/di.dart';
import 'package:base/presentation/pages/signup/bloc/bloc.dart';
import 'package:base/presentation/pages/signup/pages/signup.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupFlow {
  SignupFlow._();

  static const String path = '/signup';
  static const String name = 'signup';

  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: BlocProvider(
            create: (context) => getIt<SignupBloc>(),
            child: const SignupPage(),
          ),
        );
      },
    );
  }
}

