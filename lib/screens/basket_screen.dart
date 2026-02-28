import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_forward, size: 20),
            Text(
              'إتمام الدفع',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.cairo().fontFamily,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Stepper
                    _buildStepper(),
                    const SizedBox(height: 24),
                    // Step Content
                    if (currentStep == 0) _buildAddressStep(),
                    if (currentStep == 1) _buildPaymentStep(),
                    if (currentStep == 2) _buildConfirmationStep(),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Buttons
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => currentStep--),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'السابق',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ),
                  ),
                if (currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentStep < 2) {
                        setState(() => currentStep++);
                      } else {
                        Navigator.pushNamed(context, '/orders');
                      }
                    },
                    child: Text(
                      currentStep == 2 ? 'إتمام الطلب' : 'التالي',
                      style: TextStyle(
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...[0, 1, 2].map((step) {
          final isActive = step <= currentStep;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (step < 2) const SizedBox(width: 8),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAddressStep() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'عنوان التوصيل',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'عنوان التوصيل',
              hintStyle: const TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'طريقة الدفع',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          RadioListTile(
            value: 'card',
            groupValue: 'card',
            onChanged: (_) {},
            title: Text(
              'بطاقة ائتمان',
              style: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            ),
          ),
          RadioListTile(
            value: 'wallet',
            groupValue: 'card',
            onChanged: (_) {},
            title: Text(
              'المحفظة',
              style: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'تفاصيل الطلب',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('500 ريال'),
                  Text(
                    'الاجمالي الفرعي',
                    style: TextStyle(
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('200 ريال'),
                  Text(
                    'سعر التوصيل',
                    style: TextStyle(
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('200 ريال'),
                  Text(
                    'الضرائب',
                    style: TextStyle(
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '900 ريال',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'الاجمالي',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
