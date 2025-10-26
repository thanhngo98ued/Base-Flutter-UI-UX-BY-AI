import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base/presentation/pages/service_home/pages/service_home.screen.dart';
import 'package:base/presentation/pages/chat/pages/chat_list.screen.dart';
import 'package:base/presentation/pages/job_history/pages/job_history.page.dart';
import 'package:base/presentation/pages/notification/pages/notification.screen.dart';
import 'package:base/shared/components/app_confirm_dialog.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:base/presentation/pages/map/pages/map.screen.dart';
import 'package:base/presentation/pages/map/bloc/bloc.dart';
import 'package:base/presentation/pages/menu/pages/menu.screen.dart';
import 'package:base/router/app_router.dart';
import 'package:base/data/mock/mock_data.dart';
import 'package:go_router/go_router.dart';

/// Main screen với BottomNavigationBar
/// Quản lý 5 tabs: Home, Map, Chat, My Tasks, Menu
class MainScreen extends StatefulWidget {
  final String? phoneNumber; // Phone number from login

  const MainScreen({super.key, this.phoneNumber});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final UserModel _currentUser;
  bool _isAvailable = true; // Track availability state

  void _showNotificationScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotificationScreen(
          notifications: MockData.notifications,
          onMarkAsRead: (id) {
            // TODO: Mark notification as read
            setState(() {
              // Simulate marking as read
            });
          },
          onMarkAllAsRead: () {
            // TODO: Mark all as read
            setState(() {
              // Simulate marking all as read
            });
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    AppConfirmDialogs.showLogout(
      context: context,
      onConfirm: () {
        // TODO: Clear user data, tokens, etc.
        context.go(AppRoutes.login);
      },
    );
  }

  void _toggleAvailability() {
    setState(() {
      _isAvailable = !_isAvailable;
    });
    // TODO: Call API to update availability status
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isAvailable ? 'Bạn đang rảnh' : 'Bạn đang bận'),
        backgroundColor: _isAvailable ? Colors.green : Colors.orange,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Get current user based on phone number from login
    _currentUser = widget.phoneNumber != null
        ? MockData.getUserByPhone(widget.phoneNumber!)
        : MockData.currentUser;
    // Initialize availability state from user
    _isAvailable =  true;
  }

  List<Widget> get _screens => _currentUser.role == UserRole.worker
      ? [
          // Home for workers
          ServiceHomeScreen(
            notificationCount: MockData.notifications
                .where((n) => !n.read)
                .length,
            onNotificationClick: () => _showNotificationScreen(context),
            onServiceClick: (serviceId) {
              // TODO: Navigate to service detail or worker list
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Clicked service: $serviceId')),
              );
            },
            banners: MockData.banners,
            services: MockData.services,
            currentUser: _currentUser,
            onAvailabilityToggle: _toggleAvailability,
            isAvailable: _isAvailable,
          ),
          // Chat for workers
          ChatListScreen(
            currentUserId: _currentUser.userId.toString(),
            chats: [],
            onChatSelect: (chat) {
              context.push(
                AppRoutes.chatDetailWithId(chat.id),
                extra: {
                  'chat': chat,
                  'messages': MockData.chatMessages[chat.id] ?? [],
                },
              );
            },
          ),
          // My Tasks (Job History) for workers
          const JobHistoryPage(),
          // Menu for workers
          MenuScreen(
            currentUser: _currentUser,
            onProfileClick: () =>
                context.push(AppRoutes.profile, extra: _currentUser),
            onPriceTableClick: () => context.push(AppRoutes.priceTable),
            onLogout: () => _showLogoutDialog(context),
          ),
        ]
      : [
          // Home for customers
          ServiceHomeScreen(
            notificationCount: MockData.notifications
                .where((n) => !n.read)
                .length,
            onNotificationClick: () => _showNotificationScreen(context),
            onServiceClick: (serviceId) {
              // TODO: Navigate to service detail or worker list
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Clicked service: $serviceId')),
              );
            },
            banners: MockData.banners,
            services: MockData.services,
            currentUser: _currentUser,
            onAvailabilityToggle: _toggleAvailability,
            isAvailable: _isAvailable,
            onSearchClick: () {
              // Navigate to map screen when search is clicked
              context.push(AppRoutes.map);
            },
          ),
          // Chat for customers
          ChatListScreen(
            currentUserId: _currentUser.userId.toString(),
            chats: [],
            onChatSelect: (chat) {
              context.push(
                AppRoutes.chatDetailWithId(chat.id),
                extra: {
                  'chat': chat,
                  'messages': MockData.chatMessages[chat.id] ?? [],
                },
              );
            },
          ),
          // My Tasks (Job History) for customers
          const JobHistoryPage(),
          // Menu for customers
          MenuScreen(
            currentUser: _currentUser,
            onProfileClick: () =>
                context.push(AppRoutes.profile, extra: _currentUser),
            onPriceTableClick: () => context.push(AppRoutes.priceTable),
            onLogout: () => _showLogoutDialog(context),
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundLight,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textTertiary,
          selectedLabelStyle: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTextStyles.caption,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          items: _currentUser.role == UserRole.worker
              ? const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Trang chủ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    activeIcon: Icon(Icons.chat_bubble),
                    label: 'Tin nhắn',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.assignment_outlined),
                    activeIcon: Icon(Icons.assignment),
                    label: 'Công việc',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    activeIcon: Icon(Icons.menu_open),
                    label: 'Menu',
                  ),
                ]
              : const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Trang chủ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    activeIcon: Icon(Icons.chat_bubble),
                    label: 'Tin nhắn',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.assignment_outlined),
                    activeIcon: Icon(Icons.assignment),
                    label: 'Công việc',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    activeIcon: Icon(Icons.menu_open),
                    label: 'Menu',
                  ),
                ],
        ),
      ),
    );
  }
}
