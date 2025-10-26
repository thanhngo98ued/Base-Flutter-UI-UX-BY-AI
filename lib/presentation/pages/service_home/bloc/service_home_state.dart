import 'package:equatable/equatable.dart';
import 'package:base/domain/model/service_model.dart';

enum ServiceHomeStatus { initial, loading, success, failure }

class ServiceHomeState extends Equatable {
  final ServiceHomeStatus status;
  final List<ServiceModel> services;
  final List<BannerModel> banners;
  final int notificationCount;
  final String? errorMessage;

  const ServiceHomeState({
    this.status = ServiceHomeStatus.initial,
    this.services = const [],
    this.banners = const [],
    this.notificationCount = 0,
    this.errorMessage,
  });

  ServiceHomeState copyWith({
    ServiceHomeStatus? status,
    List<ServiceModel>? services,
    List<BannerModel>? banners,
    int? notificationCount,
    String? errorMessage,
  }) {
    return ServiceHomeState(
      status: status ?? this.status,
      services: services ?? this.services,
      banners: banners ?? this.banners,
      notificationCount: notificationCount ?? this.notificationCount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, services, banners, notificationCount, errorMessage];

  @override
  bool get stringify => true;
}

