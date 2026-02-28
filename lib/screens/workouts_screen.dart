import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = [
      {"name": "تمارين الصدر", "level": "متوسط"},
      {"name": "تمارين الظهر", "level": "مبتدئ"},
      {"name": "تمارين الأرجل", "level": "متقدم"},
      {"name": "تمارين البطن", "level": "مبتدئ"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final w = workouts[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.fitness_center,
                size: 30,
                color: Color(0xFFD81B60),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    w["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("المستوى: ${w["level"]}"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
