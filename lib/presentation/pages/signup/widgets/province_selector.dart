import 'package:base/domain/model/province.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:base/presentation/pages/signup/bloc/bloc.dart';
import 'province_selection_bottom_sheet.dart';

class ProvinceSelector extends StatelessWidget {
  const ProvinceSelector({super.key});

  void _showProvinceSelection(
    BuildContext context,
    List<Province> availableProvinces,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.textWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusLG),
          topRight: Radius.circular(AppDimensions.radiusLG),
        ),
      ),
      builder: (modalContext) => BlocProvider.value(
        value: context.read<SignupBloc>(),
        child: ProvinceSelectionBottomSheet(
          availableProvinces: availableProvinces,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, PageState<SignupUiState>>(
      builder: (context, state) {
        final uiState = state.uiState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tỉnh/Thành phố', style: AppTextStyles.label),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: uiState.availableProvinces.isEmpty
                  ? null
                  : () => _showProvinceSelection(
                      context,
                      uiState.availableProvinces,
                    ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMD,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        uiState.selectedProvince?.name ?? 'Chọn tỉnh/thành phố',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: uiState.selectedProvince != null 
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
