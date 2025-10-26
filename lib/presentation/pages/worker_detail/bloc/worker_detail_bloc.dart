import 'package:bloc/bloc.dart';

import 'worker_detail_event.dart';
import 'worker_detail_state.dart';

/// BLoC cho màn Worker Detail
class WorkerDetailBloc
    extends Bloc<WorkerDetailEvent, WorkerDetailState> {
  WorkerDetailBloc({required WorkerDetailState initialState})
      : super(initialState) {
    on<WorkerDetailLoaded>(_onLoaded);
    on<WorkerDetailHireClicked>(_onHireClicked);
    on<WorkerDetailCallClicked>(_onCallClicked);
    on<WorkerDetailChatClicked>(_onChatClicked);
  }

  /// Handler: Load worker detail
  Future<void> _onLoaded(
    WorkerDetailLoaded event,
    Emitter<WorkerDetailState> emit,
  ) async {
    emit(state.copyWith(status: WorkerDetailStatus.loading));

    try {
      // TODO: Call API to load worker detail with reviews
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(status: WorkerDetailStatus.success));
    } catch (error) {
      emit(state.copyWith(
        status: WorkerDetailStatus.failure,
        errorMessage: 'Không thể tải thông tin thợ',
      ));
    }
  }

  /// Handler: Hire worker
  Future<void> _onHireClicked(
    WorkerDetailHireClicked event,
    Emitter<WorkerDetailState> emit,
  ) async {
    emit(state.copyWith(status: WorkerDetailStatus.loading));

    try {
      // TODO: Call API to create job request with proposed price
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(status: WorkerDetailStatus.hired));
    } catch (error) {
      emit(state.copyWith(
        status: WorkerDetailStatus.failure,
        errorMessage: 'Không thể tạo yêu cầu thuê thợ',
      ));
    }
  }

  /// Handler: Call worker
  void _onCallClicked(
    WorkerDetailCallClicked event,
    Emitter<WorkerDetailState> emit,
  ) {
    // TODO: Implement phone call
    print('Call worker: ${state.worker.phone}');
  }

  /// Handler: Chat with worker
  void _onChatClicked(
    WorkerDetailChatClicked event,
    Emitter<WorkerDetailState> emit,
  ) {
    // TODO: Navigate to chat
    print('Chat with worker: ${state.worker.id}');
  }
}
