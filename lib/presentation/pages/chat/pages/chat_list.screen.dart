import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/shared/components/app_badge.dart';
import 'package:base/domain/model/chat_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListScreen extends StatefulWidget {
  final String currentUserId;
  final List<ChatModel> chats;
  final Function(ChatModel chat) onChatSelect;

  const ChatListScreen({
    super.key,
    required this.currentUserId,
    required this.chats,
    required this.onChatSelect,
  });

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final _searchController = TextEditingController();
  List<ChatModel> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _filteredChats = widget.chats;
    timeago.setLocaleMessages('vi', timeago.ViMessages());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterChats(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredChats = widget.chats;
      } else {
        _filteredChats = widget.chats.where((chat) {
          final otherUser = chat.participants.firstWhere(
            (p) => p.userId != widget.currentUserId,
          );
          return otherUser.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  String _getMessagePreview(ChatModel chat) {
    if (chat.lastMessage == null) return 'Chưa có tin nhắn';

    switch (chat.lastMessage!.type) {
      case MessageType.image:
        return '📷 Hình ảnh';
      case MessageType.video:
        return '🎥 Video';
      default:
        return chat.lastMessage!.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.backgroundLight,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tin nhắn', style: AppTextStyles.h2),
                    SizedBox(height: 16.h),
                    TextField(
                      controller: _searchController,
                      onChanged: _filterChats,
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm cuộc trò chuyện...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.textTertiary,
                          size: 20.sp,
                        ),
                        filled: true,
                        fillColor: AppColors.backgroundDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMD,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMD,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.border,
                            width: 1,
                          ),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Chat list
          Expanded(
            child: _filteredChats.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64.w,
                          color: AppColors.textTertiary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Không có cuộc trò chuyện nào',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _filteredChats.length,
                    separatorBuilder: (context, index) =>
                        Divider(height: 1, color: AppColors.divider),
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      final otherUser = chat.participants.firstWhere(
                        (p) => p.userId != widget.currentUserId,
                      );

                      return InkWell(
                        onTap: () => widget.onChatSelect(chat),
                        child: Container(
                          color: AppColors.backgroundLight,
                          padding: EdgeInsets.all(AppDimensions.paddingMD),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppAvatar(
                                imageUrl: '',
                                name: otherUser.name,
                                size: 56.w,
                                showOnlineBadge: true,
                                isOnline:   false,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            otherUser.name,
                                            style: AppTextStyles.bodyLarge
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (chat.lastMessage != null)
                                          Text(
                                            timeago.format(
                                              chat.lastMessage!.timestamp,
                                              locale: 'vi',
                                            ),
                                            style: AppTextStyles.caption,
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _getMessagePreview(chat),
                                            style: AppTextStyles.bodyMedium
                                                .copyWith(
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (chat.unreadCount > 0) ...[
                                          SizedBox(width: 8.w),
                                          AppBadge(
                                            text: chat.unreadCount > 99
                                                ? '99+'
                                                : chat.unreadCount.toString(),
                                            type: AppBadgeType.primary,
                                            isSmall: true,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
