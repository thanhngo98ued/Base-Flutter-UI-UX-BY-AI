import 'package:base/domain/model/service_model.dart';
import 'package:equatable/equatable.dart';
import 'package:base/domain/model/user_model.dart';

/// Trạng thái của màn Worker Detail
enum WorkerDetailStatus {
  initial,
  loading,
  success,
  failure,
  hired,
}

/// State của Worker Detail BLoC
class WorkerDetailState extends Equatable {
  final WorkerDetailStatus status;
  final WorkerModel worker;
  final String? errorMessage;

  const WorkerDetailState({
    this.status = WorkerDetailStatus.initial,
    required this.worker,
    this.errorMessage,
  });

  WorkerDetailState copyWith({
    WorkerDetailStatus? status,
    WorkerModel? worker,
    String? errorMessage,
  }) {
    return WorkerDetailState(
      status: status ?? this.status,
      worker: worker ?? this.worker,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, worker, errorMessage];

  @override
  bool get stringify => true;
}

