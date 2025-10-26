import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? size;
  final bool showOnlineBadge;
  final bool isOnline;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size,
    this.showOnlineBadge = false,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarSize = size ?? AppDimensions.avatarMD;

    return Stack(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildPlaceholder(),
                    errorWidget: (context, url, error) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
        ),
        if (showOnlineBadge)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: avatarSize * 0.25,
              height: avatarSize * 0.25,
              decoration: BoxDecoration(
                color: isOnline ? AppColors.online : AppColors.offline,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.backgroundLight,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    final String initials = _getInitials(name);
    return Container(
      color: AppColors.primary.withOpacity(0.1),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: (size ?? AppDimensions.avatarMD) * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }
}

