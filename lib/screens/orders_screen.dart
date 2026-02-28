import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedTabIndex = 0;

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
              'طلباتي',
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
          // Tabs
          Container(
            color: AppColors.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buildTab('طلباتي', 0), _buildTab('تفاصيل الطلب', 1)],
            ),
          ),
          // Content
          Expanded(
            child: selectedTabIndex == 0
                ? _buildOrdersList()
                : _buildOrderDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isActive = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppColors.primary : AppColors.textSecondary,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(
                'وجبة دجاج تكا',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'مطعم دجاج تكا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '23:00 2023/03',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'موافق',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Order Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'موافق',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'رقم الطلب 12565644',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.cairo().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'تاريخ الطلب 23/3/2025',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Items List
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'الوجبات',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
                const SizedBox(height: 12),
                ...[1, 2].map((i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '200 رش',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                            const Text(
                              '1',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'برجر دجاج',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                            Text(
                              'اسم الوصفة',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Delivery Details
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('1500 ريال'),
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
                      'سعر الضريبة',
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
                    const Text(
                      '2500 ريال',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'الاجمالي',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: Text(
                    'الغاء الطلب',
                    style: TextStyle(
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: Text(
                    'تقييم الطلب',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
