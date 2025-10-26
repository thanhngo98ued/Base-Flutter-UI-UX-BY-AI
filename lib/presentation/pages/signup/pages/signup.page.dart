import 'package:base/presentation/pages/signup/pages/signup.screen.dart';
import 'package:base/presentation/pages/signup/bloc/bloc.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignupBloc, PageState<SignupUiState>>(
          listenWhen: (previous, current) =>
              previous.uiState.isRegistrationSuccess !=
              current.uiState.isRegistrationSuccess,
          listener: (context, state) {
            if (state.uiState.isRegistrationSuccess) {
              // Navigate to OTP screen with phone number
              context.go('/otp?phone=${state.uiState.phone}');
            }
          },
          child: const SignupScreen(),
        ),
      ),
    );
  }
}
