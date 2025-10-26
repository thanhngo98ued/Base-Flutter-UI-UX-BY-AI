import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/shared/components/app_input_field.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/shared/components/app_confirm_dialog.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:go_router/go_router.dart';

/// Profile Screen - Content chính của màn Profile
///
/// Nhiệm vụ:
/// - Hiển thị và chỉnh sửa thông tin user
/// - Xử lý logic save/delete profile
/// - Navigation được xử lý trực tiếp
class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _experienceController;
  late final TextEditingController _servicesController;
  bool _isLoading = false;
  List<String> _selectedServices = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _addressController = TextEditingController(text:  '');
    _experienceController = TextEditingController(
      text: '5',
    ); // Default experience
    _servicesController = TextEditingController(
      text: '',
    );
    // Initialize selected services from user skills
    _selectedServices = List<String>.from( []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _experienceController.dispose();
    _servicesController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    // Validate services for workers
    if (widget.user.role == UserRole.worker && _selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn ít nhất một dịch vụ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        // TODO: Call API to save profile
        await Future.delayed(const Duration(seconds: 1)); // Simulate API call

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cập nhật thông tin thành công'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi: $e'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  void _showDeleteConfirmation() {
    AppConfirmDialogs.showDeleteAccount(
      context: context,
      onConfirm: () async {
        // TODO: Call API to delete account
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          // Navigate to login screen
          context.go('/login');
        }
      },
    );
  }

  void _showServiceSelectionBottomSheet() {
    final List<String> availableServices = [
      'Thợ điện',
      'Thợ nước',
      'Điện lạnh',
      'Thợ sơn',
      'Sửa nhà',
      'Thợ mộc',
      'Thợ hàn',
      'Vệ sinh',
      'Thông cống',
      'Lắp đặt điện',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusMD),
        ),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              return Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingLG,
                      vertical: AppDimensions.paddingSM,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.border, width: 1.h),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text('Chọn dịch vụ', style: AppTextStyles.h3),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Đóng',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // List of services
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.all(AppDimensions.paddingMD),
                      itemCount: availableServices.length,
                      itemBuilder: (context, index) {
                        final service = availableServices[index];
                        final isSelected = _selectedServices.contains(service);

                        return CheckboxListTile(
                          title: Text(service, style: AppTextStyles.bodyMedium),
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (isSelected) {
                                _selectedServices.remove(service);
                              } else {
                                _selectedServices.add(service);
                              }
                            });
                            setModalState(() {}); // Update modal state
                          },
                          activeColor: AppColors.primary,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingMD,
                            vertical: 4.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMD,
                            ),
                          ),
                          tileColor: isSelected
                              ? AppColors.primary.withOpacity(0.05)
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Hồ sơ cá nhân'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            // Avatar section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      AppAvatar(
                        imageUrl: '',
                        name: widget.user.name,
                        size: 96.w,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: AppColors.textWhite,
                              size: 20.w,
                            ),
                            onPressed: () {
                              // Pick image
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(widget.user.name, style: AppTextStyles.h3),
                  SizedBox(height: 4.h),
                  Text(
                    widget.user.role == UserRole.customer
                        ? 'Khách hàng'
                        : 'Thợ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  // Worker specific info
                  if (widget.user.role == UserRole.worker) ...[
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          '0.0',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Icon(Icons.work, color: AppColors.primary, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'true công việc',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Form section
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppInputField(
                      label: 'Họ và tên',
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppInputField(
                      label: 'Số điện thoại',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppInputField(
                      label: 'Địa chỉ',
                      controller: _addressController,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _handleSave,
                    ),
                    // Worker specific fields
                    if (widget.user.role == UserRole.worker) ...[
                      SizedBox(height: 16.h),
                      AppInputField(
                        label: 'Số năm kinh nghiệm',
                        controller: _experienceController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số năm kinh nghiệm';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Vui lòng nhập số hợp lệ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Service selection with chips
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dịch vụ cung cấp', style: AppTextStyles.label),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: _showServiceSelectionBottomSheet,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingMD,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.textWhite,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMD,
                                ),
                                border: Border.all(
                                  color: _selectedServices.isEmpty
                                      ? AppColors.border
                                      : AppColors.primary,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _selectedServices.isEmpty
                                        ? Text(
                                            'Chọn dịch vụ bạn có thể thực hiện',
                                            style: AppTextStyles.bodyMedium
                                                .copyWith(
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                          )
                                        : Wrap(
                                            spacing: 6.w,
                                            runSpacing: 6.h,
                                            children: _selectedServices
                                                .map(
                                                  (service) => Chip(
                                                    label: Text(
                                                      service,
                                                      style: AppTextStyles
                                                          .bodySmall,
                                                    ),
                                                    backgroundColor: AppColors
                                                        .primary
                                                        .withOpacity(0.1),
                                                    deleteIcon: Icon(
                                                      Icons.close,
                                                      size: 16.sp,
                                                      color: AppColors.primary,
                                                    ),
                                                    onDeleted: () {
                                                      setState(() {
                                                        _selectedServices
                                                            .remove(service);
                                                      });
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 24.h),
                    AppButton(
                      text: 'Lưu thay đổi',
                      onPressed: _handleSave,
                      isLoading: _isLoading,
                      icon: Icon(
                        Icons.save,
                        color: AppColors.textWhite,
                        size: AppDimensions.iconSM,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Danger zone
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                border: Border.all(
                  color: AppColors.error.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xóa tài khoản sẽ xóa vĩnh viễn tất cả dữ liệu của bạn. Hành động này không thể hoàn tác.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppButton(
                    text: 'Xóa tài khoản',
                    onPressed: _showDeleteConfirmation,
                    type: AppButtonType.outline,
                    backgroundColor: AppColors.error,
                    textColor: AppColors.error,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
