import 'package:base/presentation/pages/job_history/pages/job_history.page.dart';
import 'package:go_router/go_router.dart';

/// JobHistory Flow - Quản lý routing cho JobHistory module
/// 
/// Nhiệm vụ:
/// - Định nghĩa route path
class JobHistoryFlow {
  JobHistoryFlow._(); // Private constructor để prevent instantiation

  static const String path = '/job-history';
  static const String name = 'job-history';

  /// Tạo GoRoute cho JobHistory
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      builder: (context, state) => const JobHistoryPage(),
    );
  }
}

