import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الإشعارات"), centerTitle: true),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          style: ListTileStyle.drawer,
          leading: CircleAvatar(
            backgroundColor: Colors.pink,
            child: Icon(Icons.notifications, color: AppColors.surface),
          ),
          title: Text("تذكير بشرب الماء"),
          subtitle: Text("لقد مرت ساعتان منذ آخر مرة شربت فيها الماء."),
          trailing: Text(
            "10:00 ص",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
