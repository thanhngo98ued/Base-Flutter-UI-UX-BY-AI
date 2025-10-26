import 'package:equatable/equatable.dart';
import 'package:base/domain/model/user_model.dart';

enum MessageType { text, image, video }

class ChatMessageModel extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final String message;
  final MessageType type;
  final String? mediaUrl;
  final DateTime timestamp;
  final bool read;

  const ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.read,
    this.senderAvatar,
    this.mediaUrl,
  });

  ChatMessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? senderName,
    String? senderAvatar,
    String? message,
    MessageType? type,
    String? mediaUrl,
    DateTime? timestamp,
    bool? read,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      message: message ?? this.message,
      type: type ?? this.type,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
      read: read ?? this.read,
    );
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        senderName,
        senderAvatar,
        message,
        type,
        mediaUrl,
        timestamp,
        read,
      ];
}

class ChatModel extends Equatable {
  final String id;
  final List<UserModel> participants;
  final ChatMessageModel? lastMessage;
  final int unreadCount;
  final DateTime updatedAt;

  const ChatModel({
    required this.id,
    required this.participants,
    required this.unreadCount,
    required this.updatedAt,
    this.lastMessage,
  });

  ChatModel copyWith({
    String? id,
    List<UserModel>? participants,
    ChatMessageModel? lastMessage,
    int? unreadCount,
    DateTime? updatedAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, participants, lastMessage, unreadCount, updatedAt];
}

