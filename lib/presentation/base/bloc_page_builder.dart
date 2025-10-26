import 'package:base/presentation/base/app_error_handler.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:base/presentation/resources/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BlocPageBuilder<B extends StateStreamable<PageState<T>>, T>
    extends StatefulWidget {
  const BlocPageBuilder({
    super.key,
    required this.child,
    this.onPageReady,
    this.showLoading = true,
    this.onError,
  });

  final Widget child;
  final bool showLoading;
  final VoidCallback? onPageReady;
  final Function(Object)? onError;

  @override
  State<BlocPageBuilder<B, T>> createState() => _BlocPageBuilderState<B, T>();
}

class _BlocPageBuilderState<B extends StateStreamable<PageState<T>>, T>
    extends State<BlocPageBuilder<B, T>>
    with AppErrorHandler {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPageReady?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, PageState<T>>(
      listenWhen: (previous, current) =>
          previous.exception != current.exception,
      listener: (context, state) {
        if (state.exception != null) {
          handleAppError(context: context, exception: state.exception!);
          widget.onError?.call(state.exception!);
        }
      },
      child: Stack(
        children: [widget.child, if (widget.showLoading) _buildLoading()],
      ),
    );
  }

  Widget _buildLoading() {
    return BlocBuilder<B, PageState<T>>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return Visibility(
          visible: state.isLoading,
          child: Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SizedBox(
                width: 140.w,
                height: 140.w,
                child: Lottie.asset(
                  Assets.lotties.loading,
                  repeat: true,
                  fit: BoxFit.cover,
                  frameRate: FrameRate.max,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
