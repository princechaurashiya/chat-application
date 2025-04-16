// class MessageModel {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime timestamp;
//   final String messageType; // text, image, video, etc.
//   final bool isRead;

//   MessageModel({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//     this.messageType = 'text',
//     this.isRead = false,
//   });

//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     return MessageModel(
//       id: json['_id'] ?? '',
//       senderId: json['senderId'] ?? '',
//       receiverId: json['receiverId'] ?? '',
//       message: json['message'] ?? '',
//       timestamp: DateTime.parse(json['timestamp']),
//       messageType: json['messageType'] ?? 'text',
//       isRead: json['isRead'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'message': message,
//       'timestamp': timestamp.toIso8601String(),
//       'messageType': messageType,
//       'isRead': isRead,
//     };
//   }
// }
