import '../../core/common_dependencies.dart';
import '../../widgets/profile/profile_header_card.dart';
import '../../providers/user_provider.dart'; // تأكد من استيراد البروفايدر

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // جلب البيانات الحالية من البروفايدر ووضعها في الحقول
    final user = context.read<UserProvider>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? "");
    _emailController = TextEditingController(text: user?.email ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // دالة الحفظ
  void _handleSave() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("يرجى ملء جميع الحقول")));
      return;
    }

    setState(() => _isSaving = true);

    // استدعاء الدالة التي أنشأناها سابقاً في UserProvider
    bool success = await context.read<UserProvider>().updateProfile(
      name,
      email,
    );

    if (mounted) {
      setState(() => _isSaving = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم تحديث البيانات بنجاح")),
        );
        Navigator.pop(context); // العودة للخلف بعد النجاح
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("حدث خطأ أثناء الحفظ")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          "تعديل الحساب",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowRight,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // الهيدر مع الرابط الثابت (بما أن موضوع الصورة ملغي)
            ProfileHeaderCard(
              imageUrl:
                  'https://media.istockphoto.com/id/1262964459/photo/nothing-is-a-magnet-for-success-like-self-confidence.jpg?s=612x612&w=0&k=20&c=1iMsY14y_8JtWA2Oeo0TCQQYe3Jio78O1Q2MxKWZQnI=',
              isEdit:
                  true, // نجعلها false لتعطيل أيقونة الكاميرا بما أنها ملغية
            ),
            const SizedBox(height: 20),

            _buildLabel("الأسم بالكامل"),
            const SizedBox(height: 8),
            _buildTextField(controller: _nameController, hintText: "أدخل اسمك"),

            const SizedBox(height: 20),

            _buildLabel("البريد الإلكتروني"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hintText: "example@mail.com",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 40),

            // زر الحفظ مع حالة التحميل
            _isSaving
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(text: 'حفظ التعديلات', onPressed: _handleSave),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF333333),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.cairo(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
