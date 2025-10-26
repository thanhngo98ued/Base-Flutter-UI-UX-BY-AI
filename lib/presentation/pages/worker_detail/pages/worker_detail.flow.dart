import 'package:base/domain/model/service_model.dart';
import 'package:base/presentation/pages/worker_detail/bloc/bloc.dart';
import 'package:base/presentation/pages/worker_detail/pages/worker_detail.page.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Worker Detail Flow - Quản lý routing và dependencies
class WorkerDetailFlow {
  WorkerDetailFlow._();

  static const String path = '/worker-detail';
  static const String name = 'worker-detail';

  /// Tạo GoRoute cho Worker Detail
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        final worker = state.extra as WorkerModel;
        return MaterialPage(
          child: BlocProvider(
            create: (context) => WorkerDetailBloc(
              initialState: WorkerDetailState(worker: worker),
            )..add(const WorkerDetailLoaded()),
            child: const WorkerDetailPage(),
          ),
        );
      },
    );
  }
}







