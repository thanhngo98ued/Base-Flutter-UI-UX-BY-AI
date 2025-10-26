import 'package:equatable/equatable.dart';

/// Base event cho Map
abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Load dữ liệu ban đầu
class MapLoaded extends MapEvent {
  const MapLoaded();
}

/// Event: Search workers
class MapSearchSubmitted extends MapEvent {
  final String? address;
  final double radius;
  final List<String> services;
  final String? description;
  final List<Map<String, String>> media;

  const MapSearchSubmitted({
    this.address,
    required this.radius,
    required this.services,
    this.description,
    required this.media,
  });

  @override
  List<Object?> get props => [address, radius, services, description, media];
}

/// Event: Filter workers by category
class MapCategoryChanged extends MapEvent {
  final String? category;

  const MapCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

/// Event: Toggle online only filter
class MapOnlineFilterToggled extends MapEvent {
  const MapOnlineFilterToggled();
}

/// Event: Worker selected
class MapWorkerSelected extends MapEvent {
  final String workerId;

  const MapWorkerSelected(this.workerId);

  @override
  List<Object?> get props => [workerId];
}

/// Event: Search text changed
class MapSearchTextChanged extends MapEvent {
  final String searchText;

  const MapSearchTextChanged(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

