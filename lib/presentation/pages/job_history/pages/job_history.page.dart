import 'package:base/presentation/pages/job_history/pages/job_history.screen.dart';
import 'package:base/data/mock/mock_data.dart';
import 'package:flutter/material.dart';

/// JobHistory Page - wrapper
///
/// Chứa:
/// - Scaffold
/// - Load dữ liệu
class JobHistoryPage extends StatelessWidget {
  const JobHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Load jobs từ BLoC/Repository thay vì MockData
    return JobHistoryScreen(jobs: MockData.jobs);
  }
}
