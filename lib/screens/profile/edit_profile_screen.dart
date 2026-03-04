import '../../core/common_dependencies.dart';
import '../../widgets/profile/profile_header_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'عبدالله الأمير');
  final _emailController = TextEditingController(text: 'Example@email.com');

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
            // الهيدر مع تفعيل أيقونة الكاميرا
            ProfileHeaderCard(
              imageUrl: 'https://i.pravatar.cc/300',
              isEdit: true,
              onCameraTap: () {
              },
            ),
            const SizedBox(height: 20),

            // حقل الاسم
            _buildLabel("الأسم بالكامل"),
            const SizedBox(height: 8),
            _buildTextField(controller: _nameController, hintText: "أدخل اسمك"),

            const SizedBox(height: 20),

            // حقل البريد
            _buildLabel("البريد الإلكتروني"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hintText: "example@mail.com",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 40),

            // زر الحفظ
            CustomButton(
              text: 'حفظ التعديلات',
              onPressed: () {
                // منطق الحفظ هنا
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ويدجت مساعدة لبناء العناوين الصغيرة فوق الحقول
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

  // ويدجت مساعدة لبناء حقول الإدخال بنفس ستايل التصميم
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
