import 'package:bloc/bloc.dart';
import 'package:base/data/mock/mock_data.dart';
import 'service_home_event.dart';
import 'service_home_state.dart';

class ServiceHomeBloc extends Bloc<ServiceHomeEvent, ServiceHomeState> {
  ServiceHomeBloc() : super(const ServiceHomeState()) {
    on<ServiceHomeLoaded>(_onLoaded);
    on<ServiceHomeServiceClicked>(_onServiceClicked);
    on<ServiceHomeNotificationClicked>(_onNotificationClicked);
  }

  Future<void> _onLoaded(
    ServiceHomeLoaded event,
    Emitter<ServiceHomeState> emit,
  ) async {
    emit(state.copyWith(status: ServiceHomeStatus.loading));

    try {
      // TODO: Call API to load data
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        status: ServiceHomeStatus.success,
        services: MockData.services,
        banners: MockData.banners,
        notificationCount: 3, // Mock data
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ServiceHomeStatus.failure,
        errorMessage: 'Không thể tải dữ liệu',
      ));
    }
  }

  Future<void> _onServiceClicked(
    ServiceHomeServiceClicked event,
    Emitter<ServiceHomeState> emit,
  ) async {
    // TODO: Navigate to service detail
    print('Service clicked: ${event.serviceId}');
  }

  Future<void> _onNotificationClicked(
    ServiceHomeNotificationClicked event,
    Emitter<ServiceHomeState> emit,
  ) async {
    // TODO: Navigate to notification
    print('Notification clicked');
  }
}

