import 'package:equatable/equatable.dart';

abstract class ServiceHomeEvent extends Equatable {
  const ServiceHomeEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Load initial data
class ServiceHomeLoaded extends ServiceHomeEvent {
  const ServiceHomeLoaded();
}

/// Event: Service clicked
class ServiceHomeServiceClicked extends ServiceHomeEvent {
  final String serviceId;

  const ServiceHomeServiceClicked(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}

/// Event: Notification clicked
class ServiceHomeNotificationClicked extends ServiceHomeEvent {
  const ServiceHomeNotificationClicked();
}

