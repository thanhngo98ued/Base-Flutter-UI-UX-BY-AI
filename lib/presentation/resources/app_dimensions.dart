import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  AppDimensions._();

  // Padding & Margin
  static double get paddingXS => 4.w;
  static double get paddingSM => 8.w;
  static double get paddingMD => 16.w;
  static double get paddingLG => 24.w;
  static double get paddingXL => 32.w;

  // Border Radius
  static double get radiusXS => 4.r;
  static double get radiusSM => 8.r;
  static double get radiusMD => 12.r;
  static double get radiusLG => 16.r;
  static double get radiusXL => 24.r;
  static double get radiusRound => 999.r;

  // Icon Sizes
  static double get iconXS => 16.w;
  static double get iconSM => 20.w;
  static double get iconMD => 24.w;
  static double get iconLG => 32.w;
  static double get iconXL => 48.w;

  // Avatar Sizes
  static double get avatarSM => 32.w;
  static double get avatarMD => 48.w;
  static double get avatarLG => 64.w;
  static double get avatarXL => 96.w;

  // Button Heights
  static double get buttonHeightSM => 36.h;
  static double get buttonHeightMD => 48.h;
  static double get buttonHeightLG => 56.h;

  // App Bar
  static double get appBarHeight => 56.h;

  // Bottom Nav
  static double get bottomNavHeight => 64.h;

  // Card
  static double get cardElevation => 2;
  static double get cardElevationHover => 4;
}

