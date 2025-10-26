import 'package:base/domain/model/skill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/shared/components/app_input_field.dart';
import 'package:base/presentation/pages/signup/widgets/skill_selector.dart';
import 'package:base/presentation/pages/signup/widgets/id_card_section.dart';

class WorkerFieldsSection extends StatelessWidget {
  const WorkerFieldsSection({
    super.key,
    required this.yearsController,
    required this.selectedSkills,
    required this.availableSkills,
    required this.idCardFrontPath,
    required this.idCardBackPath,
    required this.isLoadingSkills,
    this.onYearsChanged,
  });

  final TextEditingController yearsController;
  final List<Skill> selectedSkills;
  final List<Skill> availableSkills;
  final String? idCardFrontPath;
  final String? idCardBackPath;
  final bool isLoadingSkills;
  final void Function(String)? onYearsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        AppInputField(
          label: 'Số năm kinh nghiệm',
          hint: 'Nhập số năm kinh nghiệm',
          controller: yearsController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onChanged: onYearsChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số năm kinh nghiệm';
            }
            final years = int.tryParse(value);
            if (years == null || years <= 0) {
              return 'Số năm phải lớn hơn 0';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        SkillSelector(
          selectedSkills: selectedSkills,
          availableSkills: availableSkills,
          isLoading: isLoadingSkills,
        ),
        SizedBox(height: 16.h),
        IdCardSection(
          frontPath: idCardFrontPath,
          backPath: idCardBackPath,
        ),
      ],
    );
  }
}

