import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_back_button.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'تفاصيل الطلب',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Download Invoice link
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.download,
                  size: 18,
                  color: AppColors.primary,
                ),
                label: const CustomText(
                  'حمل الفاتورة',
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Order Info Card
            _buildOrderInfoCard(
              status: 'جديد',
              statusColor: const Color(0xFFE3F2FD),
              statusTextColor: const Color(0xFF2196F3),
              orderNo: '1256564#',
              date: '22/3/2025  2:00م',
            ),
            const SizedBox(height: 15),

            // Restaurant Info Card
            _buildRestaurantCard(),
            const SizedBox(height: 25),

            // Meals Section
            _buildSectionHeader('الوجبات'),
            const SizedBox(height: 15),
            _buildMealsTable(),
            const SizedBox(height: 35),

            // Payment method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  'طريقة الدفع',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
                    const CustomText(
                      'المحفظة',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 8),
                    FaIcon(
                      FontAwesomeIcons.wallet,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 35),

            // Payment Details
            _buildSectionHeader('بيانات الدفع'),
            const SizedBox(height: 15),
            _buildPaymentDetails(),
            const SizedBox(height: 30),

            // Grand Total
            _buildGrandTotal(),
            const SizedBox(height: 30),

            // Large Action Button
            CustomButton(
              text: 'إلغاء الطلب',
              onPressed: () {},
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard({
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required String orderNo,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CustomText(
                    'رقم الطلب',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),

                  const SizedBox(width: 4),
                  CustomText(
                    orderNo,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              _buildStatusBadge(status, statusColor, statusTextColor),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomText(
                'تاريخ الطلب',
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 4),
              CustomText(date, fontSize: 12, color: Colors.grey[600]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text,
        fontSize: 10,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRestaurantCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFfcfcfc),
        border: Border.all(color: Colors.grey[100]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=100&auto=format&fit=crop',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 36,
                    height: 36,
                    color: Colors.orange[100],
                    child: const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.orange,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const CustomText(
                'مطعم دجاج تكا',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),

          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              minimumSize: const Size(0, 32),
            ),
            child: const CustomText(
              'التفاصيل',
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomText(title, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMealsTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2), // Meal Name (Right)
            1: FlexColumnWidth(1), // Quantity (Middle)
            2: FlexColumnWidth(1), // Price (Left)
          },
          border: TableBorder(
            verticalInside: BorderSide(color: Colors.grey[200]!),
            horizontalInside: BorderSide(color: Colors.grey[200]!),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _buildTableHeader(),
            _buildTableRow('برجر دجاج', '2', '200 ر.س'),
            _buildTableRow('دجاج برياني', '1', '200 ر.س'),
            _buildTableRow('دجاج مشوي', '1', '200 ر.س'),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[50]),
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: CustomText(
              'اسم الوجبة',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: CustomText(
              'الكمية',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: CustomText(
              'السعر',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String name, String qty, String price) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(child: CustomText(name, fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(child: CustomText(qty, fontSize: 12)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(child: CustomText(price, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      children: [
        _buildDetailRow('الاجمالي الفرعي', '1500 ريال'),
        _buildDetailRow('سعر التوصيل', '200 ريال'),
        _buildDetailRow('الضريبة المضافة', '200 ريال'),
        _buildDetailRow('نسبة الادارة', '500 ريال'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(value, fontSize: 13, color: AppColors.textPrimary),
          CustomText(label, fontSize: 13, color: Colors.grey[500]),
        ],
      ),
    );
  }

  Widget _buildGrandTotal() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText('2500 ريال', fontSize: 18, fontWeight: FontWeight.bold),
          CustomText('الاجمالي', fontSize: 16, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
