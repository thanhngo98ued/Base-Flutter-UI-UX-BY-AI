import 'package:base/di/di.dart';

/// Helper để lấy dependencies từ GetIt
T getLocator<T extends Object>() {
  return getIt<T>();
}
