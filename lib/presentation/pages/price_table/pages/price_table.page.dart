import 'package:base/presentation/pages/price_table/pages/price_table.screen.dart';
import 'package:base/data/mock/mock_data.dart';
import 'package:flutter/material.dart';

/// PriceTable Page - wrapper
///
/// Chứa:
/// - Scaffold
/// - Load dữ liệu
class PriceTablePage extends StatelessWidget {
  const PriceTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Load price table từ BLoC/Repository thay vì MockData
    return PriceTableScreen(priceTable: MockData.priceTable);
  }
}
