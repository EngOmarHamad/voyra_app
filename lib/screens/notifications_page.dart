import 'package:intl/intl.dart' show DateFormat;

import '../core/common_dependencies.dart';
import '../providers/notification_provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    // بدء جلب البيانات بمجرد فتح الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(title: const Text("الإشعارات")),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.notifications.isEmpty) {
            return const Center(child: Text("لا توجد إشعارات حالياً"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final item = provider.notifications[index];
              return InkWell(
                onTap: () => provider.markAsRead(item.id), // تحديث عند الضغط
                child: _NotificationCard(notification: item),
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // إذا كان الإشعار غير مقروء، نضع إطاراً ملوناً (كما في الصورة)
        border: notification.isRead
            ? Border.all(color: Colors.transparent)
            : Border.all(
                color: AppColors.primary.withValues(alpha: 0.5),
                width: 1.5,
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // أيقونة الإشعار داخل CircleAvatar
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: notification.isRead
                    ? Colors.grey[100]
                    : AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                color: notification.isRead ? Colors.grey : AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // محتوى الإشعار
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: notification.isRead
                              ? FontWeight.w600
                              : FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'd مارس 2025',
                          'ar',
                        ).format(notification.createdAt),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
