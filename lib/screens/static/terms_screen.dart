import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voyra_app/core/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  // محاكاة جلب البيانات من API/Firebase
  Future<List<Map<String, String>>> fetchTerms() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      {
        'title': '1. الاستخدام',
        'content':
            'يجب استخدام التطبيق بطريقة قانونية وعدم إساءة استخدام الخدمات. '
            'يُمنع مشاركة الحساب مع الآخرين أو استخدام التطبيق لأي نشاط غير قانوني. '
            'أي انتهاك لهذه القواعد قد يؤدي إلى تعليق الحساب أو حظره بشكل دائم.',
      },
      {
        'title': '2. الخصوصية',
        'content':
            'نحن نحترم خصوصيتك ونحمي بياناتك وفق أعلى المعايير. '
            'لا يتم مشاركة أي معلومات شخصية مع جهات خارجية دون موافقة صريحة منك. '
            'يمكنك الاطلاع على سياسات الخصوصية الكاملة عبر إعدادات التطبيق.',
      },
      {
        'title': '3. المسؤولية',
        'content':
            'التطبيق يقدم محتوى إرشادي ولا يتحمل مسؤولية الاستخدام الخاطئ. '
            'المستخدم مسؤول عن قراراته والإجراءات التي يتخذها بناءً على المعلومات الموجودة داخل التطبيق. '
            'نحن لا نتحمل أي أضرار مباشرة أو غير مباشرة ناتجة عن استخدام التطبيق.',
      },
      {
        'title': '4. المحتوى والمصادر',
        'content':
            'جميع المحتويات داخل التطبيق، مثل النصوص والصور والفيديوهات، محمية بحقوق الطبع والنشر. '
            'لا يجوز نسخ أو إعادة نشر أي محتوى بدون إذن خطي من صاحب حقوق النشر.',
      },
      {
        'title': '5. التحديثات',
        'content':
            'قد نقوم بتحديث التطبيق من وقت لآخر لإضافة ميزات جديدة أو تحسين الأداء. '
            'المستخدم مطالب بتحديث التطبيق بانتظام للاستفادة من جميع الخدمات والوظائف المتاحة.',
      },
      {
        'title': '6. الأمان',
        'content':
            'نحن نبذل قصارى جهدنا لتأمين بيانات المستخدمين وحمايتها من الاختراق أو الضياع. '
            'مع ذلك، المستخدم مسؤول عن حفظ بيانات الدخول وعدم مشاركتها مع أي شخص آخر.',
      },
      {
        'title': '7. التعليقات والمراجعات',
        'content':
            'أي تعليقات أو مراجعات تقدمها داخل التطبيق يجب أن تكون ملائمة وغير مسيئة. '
            'نحتفظ بحق حذف أي محتوى ينتهك سياسات الاستخدام أو القوانين المعمول بها.',
      },
      {
        'title': '8. الروابط الخارجية',
        'content':
            'قد يحتوي التطبيق على روابط لمواقع خارجية. نحن لا نتحكم بمحتوى هذه المواقع ولا نتحمل مسؤوليتها. '
            'تصفح هذه المواقع يكون على مسؤولية المستخدم الخاصة.',
      },
      {
        'title': '9. الإنهاء',
        'content':
            'يمكن للمستخدم إنهاء استخدام التطبيق في أي وقت. '
            'كما نحتفظ بحق إنهاء حساب المستخدم في حال مخالفة الشروط أو القوانين المعمول بها.',
      },
      {
        'title': '10. القوانين والاختصاص القضائي',
        'content':
            'تخضع جميع العمليات داخل التطبيق للقوانين المحلية المعمول بها. '
            'أي نزاع ينشأ عن استخدام التطبيق يخضع للاختصاص القضائي للجهات المختصة.',
      },
    ];
  }

  Widget buildSkeleton() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6, // عدد البنود
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان البند
              Container(
                width: 200, // أطول من سطر المحتوى
                height: 20,
                color: AppColors.surface,
              ),
              const SizedBox(height: 8),
              // محتوى طويل مع عدة أسطر مختلفة الطول لمحاكاة نص حقيقي
              Container(
                width: double.infinity,
                height: 14,
                color: AppColors.surface,
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity * 0.9,
                height: 14,
                color: AppColors.surface,
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity * 0.8,
                height: 14,
                color: AppColors.surface,
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity * 0.95,
                height: 14,
                color: AppColors.surface,
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity * 0.85,
                height: 14,
                color: AppColors.surface,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الشروط والأحكام")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(child: Image.asset('assets/images/logo.png', width: 90)),
          const SizedBox(height: 20),
          // استخدام Expanded ليأخذ كل المساحة المتبقية
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: fetchTerms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildSkeleton();
                } else if (snapshot.hasError) {
                  return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('لا توجد شروط حالياً'));
                }

                final terms = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: terms.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final term = terms[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          term['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(term['content']!),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
