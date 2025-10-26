import 'package:base/presentation/base/base_state_mixin.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:bloc/bloc.dart';

abstract class BaseCubit<UiState> extends Cubit<PageState<UiState>>
    with BaseStateMixin<UiState> {
  BaseCubit(UiState initialUiState) : super(PageState.initial(initialUiState));

  @override
  PageState<UiState> get currentState => state;

  @override
  void emitState(PageState<UiState> state) {
    emit(state);
  }
}

abstract class BaseBloc<Event, UiState>
    extends Bloc<Event, PageState<UiState>> with BaseStateMixin<UiState> {
  BaseBloc(UiState initialUiState) : super(PageState.initial(initialUiState));

  @override
  PageState<UiState> get currentState => state;

  @override
  void emitState(PageState<UiState> newState) {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(newState);
  }
}

