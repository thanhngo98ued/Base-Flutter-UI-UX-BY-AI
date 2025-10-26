import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/presentation/pages/map/widgets/search_worker_bottom_sheet.dart';
import 'package:base/presentation/pages/map/widgets/map_search_header.dart';
import 'package:base/presentation/pages/map/widgets/map_placeholder.dart';
import 'package:base/presentation/pages/map/widgets/map_worker_card.dart';
import 'package:base/presentation/pages/map/bloc/bloc.dart';

/// Map Screen - hiển thị thợ trên bản đồ
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusMD),
        ),
      ),
      builder: (context) => const SearchWorkerBottomSheet(),
    ).then((result) {
      if (result != null) {
        final data = result as Map;
        context.read<MapBloc>().add(
          MapSearchSubmitted(
            address: data['address'],
            radius: data['radius'],
            services: data['services'],
            description: data['description'],
            media: data['media'],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              // Search header
              MapSearchHeader(
                onSearchTap: () => _showSearchBottomSheet(context),
              ),
              // Map placeholder - Expanded to take remaining space
              Expanded(child: MapPlaceholder(workers: state.filteredWorkers)),
              // Workers horizontal list
              Container(
                height: 160.h, // Fixed height to prevent crash
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMD,
                        vertical: AppDimensions.paddingSM,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Thợ gần bạn', style: AppTextStyles.h4),
                          Text(
                            '${state.filteredWorkers.length} kết quả',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.status == MapStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingMD,
                                vertical:
                                    8.h, // Add vertical padding for shadow
                              ),
                              itemCount: state.filteredWorkers.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 12.w),
                              itemBuilder: (context, index) {
                                final worker = state.filteredWorkers[index];
                                return SizedBox(
                                  width: 300.w, // Fixed width for each card
                                  child: MapWorkerCard(worker: worker),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
