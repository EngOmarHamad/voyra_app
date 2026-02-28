import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("من نحن", style: const TextStyle(color: Colors.black)),
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
                  "فويرا هو رفيقك المثالي لتحقيق أهدافك الصحية والرياضية، حيث يجمع بين الذكاء التقني وخبرة اللياقة في منصة واحدة. يساعدك التطبيق على تتبع سعراتك الحرارية بدقة، سواء من خلال استهلاك الطعام أو النشاط البدني، مما يمنحك تحكماً كاملاً بصحتك. يوفر فويرا خططاً تمارين مخصصة تناسب مستواك البدني، سواء كنت مبتدئاً أو محترفاً، مع إمكانية حجز جلسات تدريبية مع مدربين معتمدين، كما يمكنك استكشاف مجموعة واسعة من الرياضات واختيار ما يناسبك. لا داعي للقلق بشأن تذكر مواعيد تمارينك أو وجباتك، فالإشعارات الذكية ستساعدك على البقاء على المسار الصحيح. يتميز التطبيق بواجهة سهلة الاستخدام وتصميم جذاب يجعل تجربتك سلسة وممتعة، يتيح لك أيضاً الانضمام إلى مجتمع رياضي مصغر حيث يمكنك مشاركة إنجازاتك والحصول على الدعم بفضل فويرا، ستجد أن الالتزام بأسلوب حياة صحي أصبح أسهل من أي وقت مضى. انطلق الآن وابدأ رحلتك نحو أفضل نسخة من نفسك!",
                  textAlign: TextAlign.right,
                  style: TextStyle(height: 1.7, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
