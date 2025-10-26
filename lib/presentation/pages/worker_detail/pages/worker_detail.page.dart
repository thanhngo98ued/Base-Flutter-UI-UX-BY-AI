import 'package:base/presentation/pages/worker_detail/pages/worker_detail.screen.dart';
import 'package:base/presentation/pages/worker_detail/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Worker Detail Page - wrapper với dependencies và navigation handling
class WorkerDetailPage extends StatelessWidget {
  const WorkerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkerDetailBloc, WorkerDetailState>(
      listener: (context, state) {
        if (state.status == WorkerDetailStatus.hired) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã gửi yêu cầu thuê thợ thành công!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
          // Navigate back or to job tracking
          context.pop();
        } else if (state.status == WorkerDetailStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Đã xảy ra lỗi'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: const WorkerDetailScreen(),
    );
  }
}







