class MessageModel {
  final String id;
  final String from;
  final String to;
  final String message;
  final DateTime timestamp;

  // Optional fields for scalability
  final bool isRead;
  final bool isDelivered;
  final String? type; // 'text', 'image', 'file', etc.
  final String? attachmentUrl; // if image/file

  MessageModel({
    required this.id,
    required this.from,
    required this.to,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.isDelivered = false,
    this.type = "text",
    this.attachmentUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? json['id'] ?? "",
      from: json['from'] ?? "",
      to: json['to'] ?? "",
      message: json['message'] ?? "",
      timestamp:
          json['timestamp'] is int
              ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'])
              : DateTime.tryParse(json['timestamp'] ?? "") ?? DateTime.now(),
      isRead: json['isRead'] ?? false,
      isDelivered: json['isDelivered'] ?? false,
      type: json['type'] ?? "text",
      attachmentUrl: json['attachmentUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'isDelivered': isDelivered,
      'type': type,
      'attachmentUrl': attachmentUrl,
    };
  }
}
