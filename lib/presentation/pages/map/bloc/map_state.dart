import 'package:base/domain/model/service_model.dart';
import 'package:equatable/equatable.dart';
import 'package:base/domain/model/user_model.dart';

/// Trạng thái của màn Map
enum MapStatus {
  initial,
  loading,
  success,
  failure,
}

/// State của Map BLoC
class MapState extends Equatable {
  final MapStatus status;
  final List<WorkerModel> allWorkers;
  final List<WorkerModel> filteredWorkers;
  final String? selectedCategory;
  final bool showOnlineOnly;
  final String searchText;
  final String? errorMessage;
  
  // Search criteria
  final String? searchAddress;
  final double searchRadius;
  final List<String> searchServices;
  final String? searchDescription;

  const MapState({
    this.status = MapStatus.initial,
    this.allWorkers = const [],
    this.filteredWorkers = const [],
    this.selectedCategory,
    this.showOnlineOnly = false,
    this.searchText = '',
    this.errorMessage,
    this.searchAddress,
    this.searchRadius = 10.0,
    this.searchServices = const [],
    this.searchDescription,
  });

  MapState copyWith({
    MapStatus? status,
    List<WorkerModel>? allWorkers,
    List<WorkerModel>? filteredWorkers,
    String? selectedCategory,
    bool? showOnlineOnly,
    String? searchText,
    String? errorMessage,
    String? searchAddress,
    double? searchRadius,
    List<String>? searchServices,
    String? searchDescription,
  }) {
    return MapState(
      status: status ?? this.status,
      allWorkers: allWorkers ?? this.allWorkers,
      filteredWorkers: filteredWorkers ?? this.filteredWorkers,
      selectedCategory: selectedCategory,
      showOnlineOnly: showOnlineOnly ?? this.showOnlineOnly,
      searchText: searchText ?? this.searchText,
      errorMessage: errorMessage,
      searchAddress: searchAddress,
      searchRadius: searchRadius ?? this.searchRadius,
      searchServices: searchServices ?? this.searchServices,
      searchDescription: searchDescription,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allWorkers,
        filteredWorkers,
        selectedCategory,
        showOnlineOnly,
        searchText,
        errorMessage,
        searchAddress,
        searchRadius,
        searchServices,
        searchDescription,
      ];

  @override
  bool get stringify => true;
}

