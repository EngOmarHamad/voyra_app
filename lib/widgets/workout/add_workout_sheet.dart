import 'package:provider/provider.dart';
import '../../core/common_dependencies.dart';
import '../../providers/workout_provider.dart';

class AddWorkoutSheet extends StatefulWidget {
  const AddWorkoutSheet({super.key});

  @override
  State<AddWorkoutSheet> createState() => _AddWorkoutSheetState();
}

class _AddWorkoutSheetState extends State<AddWorkoutSheet> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedLevel = 'مبتدئ';
  final List<String> _levels = ['مبتدئ', 'متوسط', 'متقدم'];
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الـ Handle اللي فوق في نص الشيت
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 25),

            Text(
              "إضافة تمرين جديد",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.cairo().fontFamily,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // حقل اسم التمرين
            CustomTextField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يرجى إدخال اسم التمرين";
                }
                if (value.length < 3) {
                  return "الاسم قصير جداً";
                }
                return null;
              },
              hint: "اسم التمرين",
              prefixIcon: const Icon(
                Icons.fitness_center,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),

            // اختيار المستوى
            Text(
              "تحديد المستوى",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.cairo().fontFamily,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _levels.map((level) {
                bool isSelected = _selectedLevel == level;
                return GestureDetector(
                  onTap: () => setState(() => _selectedLevel = level),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      level,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 35),

            // زر الحفظ
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<WorkoutProvider>().addWorkout(
                      _nameController.text,
                      _selectedLevel,
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "حفظ التمرين",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
