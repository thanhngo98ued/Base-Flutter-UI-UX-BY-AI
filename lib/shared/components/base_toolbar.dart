import 'package:base/shared/themes/base_text_styles.dart';
import 'package:base/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class BaseToolbar extends StatelessWidget {
  const BaseToolbar({
    super.key,
    this.onLeftIconPress,
    this.onRightIconPress,
    this.iconLeft,
    this.iconRight,
    this.iconSize,
    this.title,
  });

  final VoidCallback? onLeftIconPress;
  final VoidCallback? onRightIconPress;
  final Widget? iconLeft;
  final Widget? iconRight;
  final double? iconSize;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onLeftIconPress,
          icon: iconLeft ??
              SizedBox(
                width: iconSize,
                height: iconSize,
              ),
        ),
        Text(title ?? empty, style: BaseTextStyles.text16Bold),
        IconButton(
          onPressed: onRightIconPress,
          icon: iconRight ??
              SizedBox(
                width: iconSize,
                height: iconSize,
              ),
        )
      ],
    );
  }
}
