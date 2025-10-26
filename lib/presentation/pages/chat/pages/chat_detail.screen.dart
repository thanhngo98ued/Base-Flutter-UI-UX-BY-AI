import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/domain/model/chat_model.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

/// ChatDetail Screen - Content chính của màn Chi tiết chat
///
/// Nhiệm vụ:
/// - Hiển thị danh sách messages
/// - Gửi message mới
/// - Navigation được xử lý trực tiếp
class ChatDetailScreen extends StatefulWidget {
  final ChatModel chat;
  final String currentUserId;
  final List<ChatMessageModel> messages;

  const ChatDetailScreen({
    super.key,
    required this.chat,
    required this.currentUserId,
    required this.messages,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  late UserModel _otherUser;

  @override
  void initState() {
    super.initState();
    _otherUser = widget.chat.participants.firstWhere(
      (p) => p.userId != widget.currentUserId,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSend() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // TODO: Send message through BLoC
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã gửi: $message'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    _messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            AppAvatar(
              imageUrl: '',
              name: _otherUser.name,
              size: 40.w,
              showOnlineBadge: true,
              isOnline: false,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _otherUser.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                     false
                        ? 'Tôi đang rảnh'
                        : 'Tôi đang bận',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // Make phone call
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Make video call
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final message = widget.messages[index];
                final isOwn = message.senderId == widget.currentUserId;
                final showTime =
                    index == 0 ||
                    widget.messages[index - 1].timestamp
                            .difference(message.timestamp)
                            .inMinutes
                            .abs() >
                        5;

                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Column(
                    crossAxisAlignment: isOwn
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: isOwn
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isOwn) ...[
                            AppAvatar(
                              imageUrl: '',
                              name: _otherUser.name,
                              size: 32.w,
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingMD,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: isOwn
                                    ? AppColors.primary
                                    : AppColors.backgroundLight,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomLeft: Radius.circular(
                                    isOwn ? 16.r : 4.r,
                                  ),
                                  bottomRight: Radius.circular(
                                    isOwn ? 4.r : 16.r,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.shadow,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                message.message,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: isOwn
                                      ? AppColors.textWhite
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                          if (isOwn) SizedBox(width: 8.w),
                        ],
                      ),
                      if (showTime) ...[
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isOwn ? 0 : 40.w,
                          ),
                          child: Text(
                            DateFormat('HH:mm').format(message.timestamp),
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            color: AppColors.backgroundLight,
            padding: EdgeInsets.all(AppDimensions.paddingMD),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.image,
                      color: AppColors.textSecondary,
                      size: AppDimensions.iconSM,
                    ),
                    onPressed: () {
                      // Pick image
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.call,
                      color: AppColors.textSecondary,
                      size: AppDimensions.iconSM,
                    ),
                    onPressed: () {
                      // Pick video
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: AppTextStyles.bodyMedium,
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _handleSend(),
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        filled: true,
                        fillColor: AppColors.backgroundLight,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSM,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSM,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.border,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSM,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMD,
                          vertical: 10.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: AppColors.textWhite,
                        size: AppDimensions.iconSM,
                      ),
                      onPressed: _handleSend,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
