import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "سياسة الخصوصية",
          style: const TextStyle(color: Colors.black),
        ),
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
              children: const [
                Text(
                  """خصوصيتك مهمة بالنسبة لنا. إن سياسة العصف الذهني هي احترام خصوصيتك فيما يتعلق بأي معلومات قد نجمعها منك عبر موقعنا الإلكتروني والمواقع الأخرى التي نملكها ونديرها.

نحن نطلب المعلومات الشخصية فقط عندما نحتاج إليها حقاً لتقديم خدمة لك. نقوم بجمعها بوسائل عادلة وقانونية، بعلمك وموافقتك. ونخبرك أيضاً بسبب قيامنا بجمعها وكيف سيتم استخدامها.

نحن نحتفظ فقط بالمعلومات التي تم جمعها طالما كان ذلك ضرورياً لتزويدك بالخدمة المطلوبة. ما هي البيانات التي نخزنها، سنحميها ضمن وسائل مقبولة تجارياً لمنع الفقدان والسرقة، بالإضافة إلى الوصول غير المصرح به أو الكشف عنها أو النسخ أو الاستخدام أو التعديل.

نحن لا نشارك أي معلومات تعريف شخصية علناً أو مع أطراف ثالثة، إلا عندما يقتضي القانون ذلك.""",
                  textAlign: TextAlign.right,
                  style: TextStyle(height: 1.7),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
