import 'package:base/presentation/pages/map/pages/map.screen.dart';
import 'package:base/presentation/pages/map/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Map Page - wrapper với dependencies và navigation handling
class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          // Xử lý navigation hoặc side effects
          if (state.status == MapStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Đã xảy ra lỗi'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: const MapScreen(),
      ),
    );
  }
}

