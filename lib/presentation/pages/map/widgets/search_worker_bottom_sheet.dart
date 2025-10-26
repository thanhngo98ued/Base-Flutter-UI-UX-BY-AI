import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/shared/components/app_input_field.dart';

class SearchWorkerBottomSheet extends StatefulWidget {
  const SearchWorkerBottomSheet({super.key});

  @override
  State<SearchWorkerBottomSheet> createState() =>
      _SearchWorkerBottomSheetState();
}

class _SearchWorkerBottomSheetState extends State<SearchWorkerBottomSheet> {
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  double _radius = 10.0; // Default 10km
  final List<String> _selectedServices = []; // Multi-select
  final List<Map<String, String>> _selectedMedia =
      []; // {path, type: 'image' or 'video'}

  final List<String> _availableServices = [
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

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia(String type) async {
    // TODO: Implement image/video picker
    setState(() {
      _selectedMedia.add({
        'path': type == 'image' ? '/path/to/image.jpg' : '/path/to/video.mp4',
        'type': type,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(type == 'image' ? 'Đã chọn ảnh' : 'Đã chọn video'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showMediaPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusMD),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Chọn loại file', style: AppTextStyles.h3),
            SizedBox(height: 16.h),
            ListTile(
              leading: const Icon(Icons.image, color: AppColors.primary),
              title: const Text('Chọn ảnh'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia('image');
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: AppColors.secondary),
              title: const Text('Chọn video'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia('video');
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  void _openMap() {
    // TODO: Implement map picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mở Google Map để chọn địa điểm'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _handleSearch() {
    // TODO: Implement search logic
    Navigator.pop(context, {
      'address': _addressController.text,
      'radius': _radius,
      'services': _selectedServices,
      'description': _descriptionController.text,
      'media': _selectedMedia,
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radiusMD),
            ),
          ),
          child: Column(
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
                child: Column(
                  children: [
                    // Drag handle
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
                          child: Text('Tìm kiếm thợ', style: AppTextStyles.h2),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(AppDimensions.paddingLG),
                  children: [
                    // Địa chỉ
                    Text('Địa chỉ', style: AppTextStyles.label),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppInputField(
                            controller: _addressController,
                            hint: 'Nhập địa chỉ của bạn',
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMD,
                            ),
                          ),
                          child: IconButton(
                            onPressed: _openMap,
                            icon: Icon(Icons.map, color: AppColors.textWhite),
                            tooltip: 'Chọn trên bản đồ',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Bán kính tìm kiếm
                    Text('Bán kính tìm kiếm', style: AppTextStyles.label),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: _radius,
                            min: 1,
                            max: 50,
                            divisions: 49,
                            activeColor: AppColors.primary,
                            inactiveColor: AppColors.border,
                            onChanged: (value) {
                              setState(() => _radius = value);
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSM,
                            ),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Text(
                            '${_radius.toInt()} km',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Kéo để điều chỉnh bán kính từ 1-50km',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Loại dịch vụ (multi-select)
                    Text('Loại dịch vụ', style: AppTextStyles.label),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _showServiceSelectionBottomSheet(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMD,
                          vertical: AppDimensions.paddingMD,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMD,
                          ),
                          border: Border.all(
                            color: _selectedServices.isNotEmpty
                                ? AppColors.primary
                                : AppColors.border,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.build_circle,
                              color: _selectedServices.isNotEmpty
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _selectedServices.isEmpty
                                  ? Text(
                                      'Chọn loại dịch vụ',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textSecondary,
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
                                                setState(() {
                                                  _selectedServices.remove(
                                                    service,
                                                  );
                                                });
                                              },
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 0,
                                              ),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity:
                                                  VisualDensity.compact,
                                            ),
                                          )
                                          .toList(),
                                    ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Mô tả công việc
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mô tả công việc', style: AppTextStyles.label),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 4,
                          maxLength: 1000,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Mô tả chi tiết công việc cần làm...',
                            hintStyle: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            filled: true,
                            fillColor: AppColors.background,
                            counterText: '', // Hide default counter
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMD,
                              ),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMD,
                              ),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMD,
                              ),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMD,
                              ),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 1,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {}); // Update character count
                          },
                        ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${_descriptionController.text.length}/1000',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: _descriptionController.text.length > 1000
                                  ? AppColors.error
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Upload hình ảnh/video
                    Text(
                      'Hình ảnh/Video (tùy chọn)',
                      style: AppTextStyles.label,
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        ..._selectedMedia.asMap().entries.map((entry) {
                          final media = entry.value;
                          final isVideo = media['type'] == 'video';
                          return Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMD,
                              ),
                              border: Border.all(
                                color: isVideo
                                    ? AppColors.secondary
                                    : AppColors.primary,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    isVideo ? Icons.videocam : Icons.image,
                                    color: isVideo
                                        ? AppColors.secondary
                                        : AppColors.primary,
                                    size: 32.sp,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedMedia.removeAt(entry.key);
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2.w),
                                      decoration: const BoxDecoration(
                                        color: AppColors.error,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 16.sp,
                                        color: AppColors.textWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        if (_selectedMedia.length < 3)
                          GestureDetector(
                            onTap: _showMediaPicker,
                            child: Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMD,
                                ),
                                border: Border.all(
                                  color: AppColors.border,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    color: AppColors.textSecondary,
                                    size: 28.sp,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Thêm',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tối đa 3 ảnh/video',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
              // Bottom button
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingLG),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  border: Border(
                    top: BorderSide(color: AppColors.border, width: 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: AppButton(
                  text: 'Tìm kiếm thợ',
                  onPressed: _handleSearch,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showServiceSelectionBottomSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
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
                    child: Column(
                      children: [
                        // Drag handle
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
                                  Text('Chọn dịch vụ', style: AppTextStyles.h2),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${_selectedServices.length} dịch vụ đã chọn',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Xong',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // List of services
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.all(AppDimensions.paddingMD),
                      itemCount: _availableServices.length,
                      itemBuilder: (context, index) {
                        final service = _availableServices[index];
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
}
