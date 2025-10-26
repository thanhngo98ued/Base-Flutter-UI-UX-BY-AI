import 'package:base/domain/model/service_model.dart';
import 'package:bloc/bloc.dart';
import 'package:base/data/mock/mock_data.dart';
import 'package:base/domain/model/user_model.dart';

import 'map_event.dart';
import 'map_state.dart';

/// BLoC cho màn Map
class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<MapLoaded>(_onLoaded);
    on<MapSearchSubmitted>(_onSearchSubmitted);
    on<MapCategoryChanged>(_onCategoryChanged);
    on<MapOnlineFilterToggled>(_onOnlineFilterToggled);
    on<MapWorkerSelected>(_onWorkerSelected);
    on<MapSearchTextChanged>(_onSearchTextChanged);
  }

  /// Handler: Load dữ liệu
  Future<void> _onLoaded(
    MapLoaded event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
      // TODO: Call API to load workers
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        status: MapStatus.success,
        allWorkers: MockData.workers,
        filteredWorkers: MockData.workers,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: MapStatus.failure,
        errorMessage: 'Không thể tải dữ liệu',
      ));
    }
  }

  /// Handler: Submit search
  Future<void> _onSearchSubmitted(
    MapSearchSubmitted event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
      // TODO: Call API to search workers with criteria
      await Future.delayed(const Duration(seconds: 1));

      // Filter workers based on search criteria
      final filtered = _filterWorkers(
        state.allWorkers,
        services: event.services,
        radius: event.radius,
      );

      emit(state.copyWith(
        status: MapStatus.success,
        filteredWorkers: filtered,
        searchAddress: event.address,
        searchRadius: event.radius,
        searchServices: event.services,
        searchDescription: event.description,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: MapStatus.failure,
        errorMessage: 'Không thể tìm kiếm',
      ));
    }
  }

  /// Handler: Category changed
  void _onCategoryChanged(
    MapCategoryChanged event,
    Emitter<MapState> emit,
  ) {
    final filtered = _filterWorkers(
      state.allWorkers,
      category: event.category,
      searchText: state.searchText,
      onlineOnly: state.showOnlineOnly,
    );

    emit(state.copyWith(
      selectedCategory: event.category,
      filteredWorkers: filtered,
    ));
  }

  /// Handler: Toggle online filter
  void _onOnlineFilterToggled(
    MapOnlineFilterToggled event,
    Emitter<MapState> emit,
  ) {
    final newOnlineOnly = !state.showOnlineOnly;
    final filtered = _filterWorkers(
      state.allWorkers,
      category: state.selectedCategory,
      searchText: state.searchText,
      onlineOnly: newOnlineOnly,
    );

    emit(state.copyWith(
      showOnlineOnly: newOnlineOnly,
      filteredWorkers: filtered,
    ));
  }

  /// Handler: Worker selected
  void _onWorkerSelected(
    MapWorkerSelected event,
    Emitter<MapState> emit,
  ) {
    // Worker selected event - navigation sẽ được xử lý ở Page layer
    // Không cần xử lý gì ở đây, chỉ để track
  }

  /// Handler: Search text changed
  void _onSearchTextChanged(
    MapSearchTextChanged event,
    Emitter<MapState> emit,
  ) {
    final filtered = _filterWorkers(
      state.allWorkers,
      category: state.selectedCategory,
      searchText: event.searchText,
      onlineOnly: state.showOnlineOnly,
    );

    emit(state.copyWith(
      searchText: event.searchText,
      filteredWorkers: filtered,
    ));
  }

  // ==================== Helper Methods ====================

  List<WorkerModel> _filterWorkers(
    List<WorkerModel> workers, {
    String? category,
    String? searchText,
    bool onlineOnly = false,
    List<String>? services,
    double? radius,
  }) {
    return workers.where((worker) {
      final matchesSearch = searchText == null ||
          searchText.isEmpty ||
          worker.name.toLowerCase().contains(searchText.toLowerCase()) ||
          worker.skills!.any(
            (skill) => skill.toLowerCase().contains(searchText.toLowerCase()),
          );

      final matchesCategory = category == null || worker.skills!.contains(category);

      final matchesOnline = !onlineOnly || worker.isOnline!;

      final matchesServices = services == null ||
          services.isEmpty ||
          services.any((service) => worker.skills!.contains(service));

      final matchesRadius = radius == null || worker.distance! <= radius;

      return matchesSearch &&
          matchesCategory &&
          matchesOnline &&
          matchesServices &&
          matchesRadius;
    }).toList();
  }
}

