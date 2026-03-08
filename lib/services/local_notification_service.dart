import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        );

    // في الإصدارات الحديثة، يتم تمرير الإعدادات كمعامل مسمى أحياناً أو مباشرة حسب التحديث
    // ولكن الأهم هو التأكد من الصلاحيات في أندرويد 13+
    await _notificationsPlugin.initialize(settings: initializationSettings);
  }

  static void showInstantNotification({
    required String title,
    required String body,
  }) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "profile_updates", // ID القناة
        "تحديثات الحساب", // اسم القناة
        importance: Importance.max,
        priority: Priority.high,
        // تأكد من إضافة هذه الخصائص للإصدارات الحديثة
        showWhen: true,
      ),
      iOS: DarwinNotificationDetails(),
    );

    // التعديل الجذري هنا: يجب تسمية كل المعاملات (Named Arguments)
    await _notificationsPlugin.show(
      id: DateTime.now().millisecond % 10000, // يجب كتابة id:
      title: title, // يجب كتابة title:
      body: body, // يجب كتابة body:
      notificationDetails:
          notificationDetails, // يجب كتابة notificationDetails:
    );
  }
}
