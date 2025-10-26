import 'package:base/presentation/pages/price_table/pages/price_table.page.dart';
import 'package:go_router/go_router.dart';

/// PriceTable Flow - Quản lý routing cho PriceTable module
/// 
/// Nhiệm vụ:
/// - Định nghĩa route path
class PriceTableFlow {
  PriceTableFlow._(); // Private constructor để prevent instantiation

  static const String path = '/price-table';
  static const String name = 'price-table';

  /// Tạo GoRoute cho PriceTable
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      builder: (context, state) => const PriceTablePage(),
    );
  }
}

