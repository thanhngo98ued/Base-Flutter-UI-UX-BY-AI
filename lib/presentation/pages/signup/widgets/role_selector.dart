import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:base/presentation/pages/signup/bloc/bloc.dart';

class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, PageState<SignupUiState>>(
      builder: (context, state) {
        final uiState = state.uiState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loại tài khoản', style: AppTextStyles.label),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text(
                      'Khách hàng',
                      style: AppTextStyles.bodyMedium,
                    ),
                    value: 'customer',
                    groupValue: uiState.role,
                    onChanged: (value) {
                      context.read<SignupBloc>().add(SignupRoleChanged(value!));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text(
                      'Thợ',
                      style: AppTextStyles.bodyMedium,
                    ),
                    value: 'worker',
                    groupValue: uiState.role,
                    onChanged: (value) {
                      context.read<SignupBloc>().add(SignupRoleChanged(value!));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

