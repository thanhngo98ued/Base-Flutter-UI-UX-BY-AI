import 'package:go_router/go_router.dart';

// Auth flows
import 'package:base/presentation/pages/splash/pages/splash.screen.dart';
import 'package:base/presentation/pages/login/pages/login.flow.dart';
import 'package:base/presentation/pages/signup/pages/signup.flow.dart';
import 'package:base/presentation/pages/forgot_password/pages/forgot_password.flow.dart';
import 'package:base/presentation/pages/otp/pages/otp.flow.dart';
import 'package:base/presentation/pages/reset_password/pages/reset_password.flow.dart';

// Main screens
import 'package:base/presentation/pages/main/main_screen.dart';

// Feature flows
import 'package:base/presentation/pages/profile/pages/profile.flow.dart';
import 'package:base/presentation/pages/chat/pages/chat_detail.flow.dart';
import 'package:base/presentation/pages/job_history/pages/job_history.flow.dart';
import 'package:base/presentation/pages/price_table/pages/price_table.flow.dart';
import 'package:base/presentation/pages/map/pages/map.flow.dart';
import 'package:base/presentation/pages/notification_detail/pages/notification_detail.flow.dart';
import 'package:base/presentation/pages/worker_detail/pages/worker_detail.flow.dart';
import 'package:base/presentation/pages/deposit/pages/deposit.flow.dart';

/// Global router instance
final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    // Splash
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splashName,
      builder: (context, state) => const SplashScreen(),
    ),

    // Auth routes
    LoginFlow.route(),
    SignupFlow.route(),
    ForgotPasswordFlow.route(),
    OTPFlow.route(),
    ResetPasswordFlow.route(),

    // Main app with bottom navigation
    GoRoute(
      path: AppRoutes.main,
      name: AppRoutes.mainName,
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'];
        return MainScreen(phoneNumber: phone);
      },
    ),

    // Feature routes với Flow pattern
    ProfileFlow.route(),
    JobHistoryFlow.route(),
    PriceTableFlow.route(),
    ChatDetailFlow.route(),
    MapFlow.route(),
    NotificationDetailFlow.route(),
    WorkerDetailFlow.route(),
    DepositFlow.route(),
  ],
);

/// App route paths
class AppRoutes {
  AppRoutes._();

  // Auth routes
  static const String splash = '/splash';
  static const String splashName = 'splash';

  static const String login = '/login';
  static const String loginName = 'login';

  static const String signup = '/signup';
  static const String signupName = 'signup';

  static const String otp = '/otp';
  static const String otpName = 'otp';

  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordName = 'forgot-password';

  static const String resetPassword = '/reset-password';
  static const String resetPasswordName = 'reset-password';

  // Main routes
  static const String main = '/';
  static const String mainName = 'main';

  // Full-screen routes
  static const String profile = '/profile';
  static const String profileName = 'profile';

  static const String jobHistory = '/job-history';
  static const String jobHistoryName = 'job-history';

  static const String priceTable = '/price-table';
  static const String priceTableName = 'price-table';

  static const String chatDetail = '/chat';
  static const String chatDetailName = 'chat-detail';

  static const String map = '/map';
  static const String mapName = 'map';

  static const String notificationDetail = '/notification-detail';
  static const String notificationDetailName = 'notification-detail';

  static const String workerDetail = '/worker-detail';
  static const String workerDetailName = 'worker-detail';

  static const String deposit = '/deposit';
  static const String depositName = 'deposit';

  // Helper methods for navigation with params
  static String chatDetailWithId(String id) => '$chatDetail/$id';
}
