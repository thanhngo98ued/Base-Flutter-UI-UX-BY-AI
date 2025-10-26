import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:base/presentation/pages/deposit/pages/deposit.screen.dart';

/// Deposit Flow - Quản lý navigation cho màn nộp tiền
class DepositFlow {
  DepositFlow._();

  static GoRoute route() {
    return GoRoute(
      path: '/deposit',
      name: 'deposit',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: DepositScreen(),
        );
      },
    );
  }
}

