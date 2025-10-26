import 'package:base/domain/model/skill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/presentation/pages/signup/bloc/bloc.dart';
import 'package:base/presentation/pages/signup/widgets/skill_selection_bottom_sheet.dart';

class SkillSelector extends StatelessWidget {
  const SkillSelector({
    super.key,
    required this.selectedSkills,
    required this.availableSkills,
    required this.isLoading,
  });

  final List<Skill> selectedSkills;
  final List<Skill> availableSkills;
  final bool isLoading;

  void _showSkillSelection(BuildContext context) {
    if (isLoading || availableSkills.isEmpty) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusMD),
        ),
      ),
      builder: (modalContext) => BlocProvider.value(
        value: context.read<SignupBloc>(),
        child: SkillSelectionBottomSheet(availableSkills: availableSkills),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kỹ năng', style: AppTextStyles.label),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showSkillSelection(context),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.textWhite,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(
                color: selectedSkills.isEmpty
                    ? AppColors.border
                    : AppColors.primary,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: isLoading
                      ? Text(
                          'Đang tải kỹ năng...',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        )
                      : selectedSkills.isEmpty
                      ? Text(
                          'Chọn kỹ năng bạn có thể thực hiện',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        )
                      : Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: selectedSkills
                              .map(
                                (skill) => Chip(
                                  label: Text(
                                    skill.skillName,
                                    style: AppTextStyles.bodySmall,
                                  ),
                                  backgroundColor: AppColors.primary
                                      .withOpacity(0.1),
                                  deleteIcon: Icon(
                                    Icons.close,
                                    size: 16.sp,
                                    color: AppColors.primary,
                                  ),
                                  onDeleted: () {
                                    context.read<SignupBloc>().add(
                                      SignupSkillToggled(skill),
                                    );
                                  },
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 0,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                              .toList(),
                        ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_drop_down,
                  color: isLoading
                      ? AppColors.textTertiary
                      : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
