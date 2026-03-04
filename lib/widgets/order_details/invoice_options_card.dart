import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voyra_app/widgets/order_details/section_header.dart';
import '../../core/app_theme.dart';
import '../../widgets/custom_text.dart';

class InvoiceOptionsCard extends StatelessWidget {
  final VoidCallback onDownloadPdf;
  final VoidCallback onSaveImage;
  final VoidCallback onShareImage;

  const InvoiceOptionsCard({
    super.key,
    required this.onDownloadPdf,
    required this.onSaveImage,
    required this.onShareImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionHeader(title: 'خيارات الفاتورة'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOption(
                icon: FontAwesomeIcons.filePdf,
                label: 'تحميل PDF',
                onTap: onDownloadPdf,
                color: Colors.redAccent,
              ),
              _buildOption(
                icon: FontAwesomeIcons.download,
                label: 'حفظ الصورة',
                onTap: onSaveImage,
                color: Colors.green,
              ),
              _buildOption(
                icon: FontAwesomeIcons.share,
                label: 'مشاركة',
                onTap: onShareImage,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 20, color: color),
            const SizedBox(height: 8),
            CustomText(
              label,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
