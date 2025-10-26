import 'dart:async';
import 'package:bloc/bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

/// BLoC cho màn OTP
class OTPBloc extends Bloc<OTPEvent, OTPState> {
  Timer? _timer;

  OTPBloc() : super(const OTPState()) {
    on<OTPDigitChanged>(_onDigitChanged);
    on<OTPSubmitted>(_onSubmitted);
    on<OTPResendRequested>(_onResendRequested);
    on<OTPTimerTicked>(_onTimerTicked);

    // Start timer
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    add(const OTPTimerTicked(60));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerDuration > 0) {
        add(OTPTimerTicked(state.timerDuration - 1));
      } else {
        timer.cancel();
      }
    });
  }

  /// Handler: Digit changed
  void _onDigitChanged(
    OTPDigitChanged event,
    Emitter<OTPState> emit,
  ) {
    final newDigits = List<String>.from(state.digits);
    newDigits[event.index] = event.digit;
    emit(state.copyWith(digits: newDigits));
  }

  /// Handler: Submit OTP
  Future<void> _onSubmitted(
    OTPSubmitted event,
    Emitter<OTPState> emit,
  ) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: OTPStatus.loading));

    try {
      // TODO: Call API verify OTP
      await Future.delayed(const Duration(seconds: 2));

      // Demo: OTP đúng là "123456"
      if (state.otp == '123456') {
        emit(state.copyWith(status: OTPStatus.success));
      } else {
        emit(state.copyWith(
          status: OTPStatus.failure,
          errorMessage: 'Mã OTP không đúng',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: OTPStatus.failure,
        errorMessage: 'Đã xảy ra lỗi: $error',
      ));
    }
  }

  /// Handler: Resend OTP
  Future<void> _onResendRequested(
    OTPResendRequested event,
    Emitter<OTPState> emit,
  ) async {
    try {
      // TODO: Call API resend OTP
      await Future.delayed(const Duration(seconds: 1));

      // Clear digits and restart timer
      emit(state.copyWith(
        digits: ['', '', '', ''],
        timerDuration: 60,
        canResend: false,
      ));
      _startTimer();
    } catch (error) {
      emit(state.copyWith(
        status: OTPStatus.failure,
        errorMessage: 'Không thể gửi lại OTP',
      ));
    }
  }

  /// Handler: Timer tick
  void _onTimerTicked(
    OTPTimerTicked event,
    Emitter<OTPState> emit,
  ) {
    emit(state.copyWith(
      timerDuration: event.duration,
      canResend: event.duration == 0,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

