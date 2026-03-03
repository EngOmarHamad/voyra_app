import 'package:flutter/material.dart';
import 'package:voyra_app/widgets/contact_us/social_button.dart';
import 'package:voyra_app/widgets/custom_text_field.dart';
import '../../core/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = '+970';
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    titleController.dispose();
    messageController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("تواصل معنا", style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Center(child: Image.asset('assets/images/logo.png', width: 90)),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "يسعدنا تواصلك معنا، يمكنك مراسلتنا مباشرة أو عبر منصات التواصل الاجتماعية",
                  textAlign: TextAlign.right,
                  style: TextStyle(height: 1.6),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(
                      icon: FontAwesomeIcons.facebookF,
                      color: const Color(0xFF1877F2),
                    ),
                    SocialButton(
                      icon: FontAwesomeIcons.xTwitter,
                      color: Colors.black,
                    ),
                    SocialButton(
                      icon: FontAwesomeIcons.instagram,
                      color: const Color(0xFFE1306C),
                    ),
                    SocialButton(
                      icon: FontAwesomeIcons.whatsapp,
                      color: const Color(0xFF25D366),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: nameController,
                  hint: "اسم المستخدم",
                  prefixIcon: const Center(
                    widthFactor: 1.0,
                    child: FaIcon(FontAwesomeIcons.solidUser, size: 14),
                  ),
                ),
                const SizedBox(height: 20),

                PhoneInputField(
                  controller: phoneController,
                  initialCountryCode: selectedCountryCode,
                  onCountryCodeChanged: (code) {
                    setState(() {
                      selectedCountryCode = code;
                    });
                  },
                ),
                _input(
                  "البريد الإلكتروني",
                  controller: emailController,
                  icon: FontAwesomeIcons.solidEnvelope,
                ),
                CustomTextField(
                  controller: emailController,
                  hint: "البريد الإلكتروني",
                  prefixIcon: const Center(
                    widthFactor: 1.0,
                    child: FaIcon(FontAwesomeIcons.solidEnvelope, size: 14),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: titleController,
                  hint: "عنوان الرسالة",
                  prefixIcon: const Center(
                    widthFactor: 1.0,
                    child: FaIcon(FontAwesomeIcons.penNib, size: 14),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: messageController,
                  hint: "نص الرسالة",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FaIcon(FontAwesomeIcons.solidMessage, size: 14),
                    ),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 25),

                /// 🚀 Send Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      String fullPhone =
                          '$selectedCountryCode ${phoneController.text}';
                      // Handle form submission here (API call, etc.)
                      print("الاسم: ${nameController.text}");
                      print("الهاتف: $fullPhone");
                      print("البريد: ${emailController.text}");
                      print("العنوان: ${titleController.text}");
                      print("الرسالة: ${messageController.text}");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("تم إرسال الرسالة بنجاح")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD81B60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "إرسال الرسالة",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.surface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Generic input field widget
  Widget _input(
    String hint, {
    int maxLines = 1,
    IconData? icon,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon != null
              ? Center(widthFactor: 1.0, child: FaIcon(icon, size: 14))
              : null,
          filled: true,
          fillColor: AppColors.surface,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD81B60), width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/// Phone input field with country code selector
class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final String initialCountryCode;
  final ValueChanged<String>? onCountryCodeChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.initialCountryCode = '+970',
    this.onCountryCodeChanged,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late String selectedCountryCode;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedCountryCode = widget.initialCountryCode;
    focusNode.addListener(() {
      setState(() {}); // Update border on focus
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isFocused ? const Color(0xFFD81B60) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            /// 🔹 TextField for phone number
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 4),
                child: TextField(
                  controller: widget.controller,
                  focusNode: focusNode,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "رقم الجوال",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 12,
                    ),
                    prefixIcon: Center(
                      widthFactor: 1.0,
                      child: FaIcon(FontAwesomeIcons.phone, size: 14),
                    ),
                  ),
                ),
              ),
            ),

            /// 🔹 Separator
            Container(height: 20, width: 1, color: Colors.grey.shade300),

            /// 🔹 Country code dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: DropdownButton<String>(
                value: selectedCountryCode,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: '+970', child: Text('+970')),
                  DropdownMenuItem(value: '+20', child: Text('+20')),
                  DropdownMenuItem(value: '+966', child: Text('+966')),
                  DropdownMenuItem(value: '+971', child: Text('+971')),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    selectedCountryCode = value;
                  });
                  if (widget.onCountryCodeChanged != null) {
                    widget.onCountryCodeChanged!(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
