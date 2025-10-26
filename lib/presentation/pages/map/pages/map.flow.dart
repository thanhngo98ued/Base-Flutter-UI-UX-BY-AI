import 'package:base/presentation/pages/map/bloc/bloc.dart';
import 'package:base/presentation/pages/map/pages/map.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Map Flow - Quản lý routing và dependencies cho Map module
class MapFlow {
  MapFlow._();

  static const String path = '/map';
  static const String name = 'map';

  /// Tạo GoRoute cho Map
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: BlocProvider(
            create: (context) => MapBloc()..add(const MapLoaded()),
            child: const MapPage(),
          ),
        );
      },
    );
  }
}

