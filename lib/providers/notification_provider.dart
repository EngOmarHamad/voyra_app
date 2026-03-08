import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../core/common_dependencies.dart';

class NotificationProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // جلب الإشعارات الخاصة بالمستخدم الحالي
  void fetchNotifications() {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) return;

    _isLoading = true;

    _db
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .orderBy('createdAt', descending: true) // الأحدث أولاً
        .snapshots() // استخدام Stream للتحديث اللحظي
        .listen((snapshot) {
          _notifications = snapshot.docs.map((doc) {
            return NotificationModel.fromFirestore(doc.data(), doc.id);
          }).toList();

          _isLoading = false;
          notifyListeners();
        });
  }

  // تحديث حالة الإشعار إلى "مقروء" في Firebase
  Future<void> markAsRead(String notificationId) async {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      debugPrint("Error marking notification as read: $e");
    }
  }

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // دالة تهيئة الإشعارات
  Future<void> initPushNotifications() async {
    try {
      // 1. طلب إذن المستخدم (مهم جداً لأندرويد 13+ و iOS)
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // 2. الحصول على التوكن الخاص بالجهاز
        String? token = await _fcm.getToken();

        if (token != null) {
          String uid = _auth.currentUser!.uid;
          // 3. حفظ التوكن في مستند المستخدم
          await _db.collection('users').doc(uid).set({
            'fcmToken': token,
            'platform': Platform.isAndroid
                ? 'Android'
                : Platform.isIOS
                ? 'iOS'
                : 'Web', // حل مشكلة الـ context
            'lastUpdate': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          debugPrint("FCM Token Saved: $token");
        }
      }
    } catch (e) {
      debugPrint("Error initializing FCM: $e");
    }
  }
}
