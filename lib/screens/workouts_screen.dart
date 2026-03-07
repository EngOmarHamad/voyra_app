import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:voyra_app/models/workout_model.dart';
import '../core/common_dependencies.dart';
import '../providers/workout_provider.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    if (workoutProvider.isLoading) {
      return _buildShimmerLoading();
    }

    return AnimationLimiter(
      // 👈 أنيميشن دخول القائمة
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workoutProvider.workouts.length,
        itemBuilder: (context, index) {
          final workout = workoutProvider.workouts[index];

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              // 👈 انزلاق الكروت عند التحميل
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Dismissible(
                    key: Key(workout.id),
                    direction: DismissDirection.endToStart,

                    // تحسين شكل الخلفية أثناء السحب 👇
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Colors.redAccent, Colors.red],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "حذف",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.delete_sweep,
                            color: Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                    ),

                    // تأكيد الحذف مع أنيميشن خفيف 👇
                    confirmDismiss: (direction) async {
                      return await _showDeleteConfirmation(context);
                    },

                    onDismissed: (direction) {
                      workoutProvider.deleteWorkout(workout.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("تم حذف ${workout.name}"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    },
                    child: _buildWorkoutCard(workout),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // أيقونة التنبيه في الأعلى
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.redAccent,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              // العنوان
              Text(
                "تأكيد الحذف",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // نص المحتوى
              Text(
                "هل أنت متأكد من حذف هذا التمرين؟\nلا يمكن التراجع عن هذه الخطوة.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

            // الأزرار داخل الـ Row
              Row(
                children: [
                  // زر الإلغاء
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        // 👇 تحديد ارتفاع ثابت للزرين (مثلاً 48)
                        minimumSize: const Size.fromHeight(48),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // زر الحذف
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        // 👇 نفس الارتفاع الثابت هنا أيضاً
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "حذف",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(WorkoutModel workout) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD81B60).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.fitness_center,
              color: Color(0xFFD81B60),
              size: 26,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "المستوى: ${workout.level}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_back_ios_new, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 90,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
