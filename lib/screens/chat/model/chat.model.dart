class ChatMessageModel {
  final String role;
  final String content;

  ChatMessageModel({
    required this.role,
    required this.content,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      role: json['role'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }

  ChatMessageModel copyWith({
    String? role,
    String? content,
  }) {
    return ChatMessageModel(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
}



class ChatModel {
  final String uid;
  final String userId;
  final String agentId;
  final List<ChatMessageModel> messages;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.uid,
    required this.userId,
    required this.agentId,
    required this.messages,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      uid: json['uid'],
      userId: json['userId'],
      agentId: json['agentId'],
      messages: (json['chatMessages'] as List).map((e) => ChatMessageModel.fromJson(e)).toList(),
      title: json['title'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userId': userId,
      'agentId': agentId,
      'chatMessages': messages.map((e) => e.toJson()).toList(),
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ChatModel copyWith({
    String? uid,
    String? userId,
    String? agentId,
    List<ChatMessageModel>? messages,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatModel(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      agentId: agentId ?? this.agentId,
      messages: messages ?? this.messages,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}