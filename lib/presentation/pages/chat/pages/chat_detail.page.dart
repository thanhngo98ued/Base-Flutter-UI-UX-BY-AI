import 'package:base/presentation/pages/chat/pages/chat_detail.screen.dart';
import 'package:base/domain/model/chat_model.dart';
import 'package:base/data/mock/mock_data.dart';
import 'package:flutter/material.dart';

/// ChatDetail Page - wrapper
///
/// Chứa:
/// - Scaffold
/// - Load dữ liệu
class ChatDetailPage extends StatelessWidget {
  final String chatId;
  final ChatModel? chat;
  final List messages;

  const ChatDetailPage({
    super.key,
    required this.chatId,
    this.chat,
    this.messages = const [],
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Load chat từ BLoC/Repository thay vì MockData
    final chatData = chat ?? MockData.chats.first;
    final chatMessages = messages.isNotEmpty
        ? messages.cast<ChatMessageModel>().toList()
        : <ChatMessageModel>[];

    return ChatDetailScreen(
      chat: chatData,
      currentUserId: MockData.currentUser.userId.toString(),
      messages: chatMessages,
    );
  }
}
