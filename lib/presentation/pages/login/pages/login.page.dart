import 'package:base/presentation/pages/login/pages/login.screen.dart';
import 'package:base/presentation/pages/login/bloc/bloc.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:base/router/app_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginCubit, PageState<LoginUiState>>(
          listenWhen: (previous, current) =>
              previous.uiState.user != current.uiState.user,
          listener: (context, state) {
            if (state.uiState.user != null) {
              context.go('${AppRoutes.main}?phone=${state.uiState.phone}');
            }
          },
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
