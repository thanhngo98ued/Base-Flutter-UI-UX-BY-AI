import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/domain/model/service_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppBannerCarousel extends StatefulWidget {
  final List<BannerModel> banners;
  final double height;
  final Duration autoPlayInterval;

  const AppBannerCarousel({
    super.key,
    required this.banners,
    this.height = 200,
    this.autoPlayInterval = const Duration(seconds: 5),
  });

  @override
  State<AppBannerCarousel> createState() => _AppBannerCarouselState();
}

class _AppBannerCarouselState extends State<AppBannerCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(widget.autoPlayInterval, () {
      if (mounted && widget.banners.isNotEmpty) {
        final nextPage = (_currentPage + 1) % widget.banners.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return SizedBox(height: widget.height.h);
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          child: SizedBox(
            height: widget.height.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: widget.banners.length,
              itemBuilder: (context, index) {
                final banner = widget.banners[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: banner.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.backgroundDark,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.backgroundDark,
                        child: Icon(
                          Icons.image_not_supported,
                          size: AppDimensions.iconXL,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: AppDimensions.paddingMD,
                      left: AppDimensions.paddingMD,
                      right: AppDimensions.paddingMD,
                      child: Text(
                        banner.title,
                        style: AppTextStyles.h4.copyWith(
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        if (widget.banners.length > 1)
          Positioned(
            bottom: AppDimensions.paddingMD,
            right: AppDimensions.paddingMD,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.banners.length,
              effect: WormEffect(
                dotWidth: 8.w,
                dotHeight: 8.h,
                activeDotColor: AppColors.textWhite,
                dotColor: AppColors.textWhite.withOpacity(0.5),
              ),
            ),
          ),
      ],
    );
  }
}
