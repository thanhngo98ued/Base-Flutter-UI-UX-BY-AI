import 'package:base/presentation/pages/chat/pages/chat_detail.page.dart';
import 'package:base/domain/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ChatDetail Flow - Quản lý routing cho ChatDetail module
/// 
/// Nhiệm vụ:
/// - Định nghĩa route path
/// - Xử lý parameters từ router
class ChatDetailFlow {
  ChatDetailFlow._(); // Private constructor để prevent instantiation

  static const String path = '/chat/:id';
  static const String name = 'chat-detail';

  /// Tạo GoRoute cho ChatDetail
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        final chatId = state.pathParameters['id'];
        final extra = state.extra as Map<String, dynamic>?;
        final chat = extra?['chat'] as ChatModel?;
        final messages = extra?['messages'] as List? ?? [];

        return MaterialPage(
          child: ChatDetailPage(
            chatId: chatId ?? '',
            chat: chat,
            messages: messages,
          ),
        );
      },
    );
  }
}

