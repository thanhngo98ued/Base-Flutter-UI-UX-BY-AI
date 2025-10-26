import 'package:base/domain/model/skill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:base/presentation/pages/signup/bloc/bloc.dart';

class SkillSelectionBottomSheet extends StatelessWidget {
  const SkillSelectionBottomSheet({
    super.key,
    required this.availableSkills,
  });

  final List<Skill> availableSkills;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, PageState<SignupUiState>>(
      builder: (context, state) {
        final uiState = state.uiState;
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLG,
                    vertical: AppDimensions.paddingSM,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.border,
                        width: 1.h,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Chọn kỹ năng', style: AppTextStyles.h2),
                                SizedBox(height: 4.h),
                                Text(
                                  '${uiState.selectedSkills.length} kỹ năng đã chọn',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.all(AppDimensions.paddingLG),
                    itemCount: availableSkills.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final skill = availableSkills[index];
                      final isSelected = uiState.selectedSkills
                          .any((selected) => selected.skillId == skill.skillId);

                      return GestureDetector(
                        onTap: () {
                          context.read<SignupBloc>().add(SignupSkillToggled(skill));
                        },
                        child: Container(
                          padding: EdgeInsets.all(AppDimensions.paddingSM),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withOpacity(0.1)
                                : AppColors.textWhite,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6.r),
                                child: Container(
                                  width: 36.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.border,
                                    image: DecorationImage(
                                      image: NetworkImage(skill.skillIcon),
                                      fit: BoxFit.cover,
                                      onError: (exception, stackTrace) {
                                        // Handle image load error
                                      },
                                    ),
                                  ),
                                  child: skill.skillIcon.isEmpty
                                      ? Icon(
                                          Icons.build,
                                          color: AppColors.textSecondary,
                                          size: 20.sp,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  skill.skillName,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                    fontWeight: isSelected 
                                        ? FontWeight.w600 
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                  size: 18.sp,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
