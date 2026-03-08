import '../core/common_dependencies.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
  });

  // تحويل البيانات من Firestore Map إلى كائن NotificationModel
  factory NotificationModel.fromFirestore(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return NotificationModel(
      id: documentId,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      // التعامل مع نوع Timestamp الخاص بـ Firebase
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      isRead: json['isRead'] ?? false,
    );
  }
}
