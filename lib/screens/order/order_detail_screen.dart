// import 'dart:typed_data';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:voyra_app/core/snackbar_helper.dart';

import '../../core/common_dependencies.dart';
import '../../core/invoice_generator.dart';

import '../../widgets/order_details/action_button.dart';
import '../../widgets/order_details/cancel_dialog.dart';
import '../../widgets/order_details/cancellation_section.dart';
import '../../widgets/order_details/invoice_options_card.dart';
import '../../widgets/order_details/meals_table.dart';
import '../../widgets/order_details/order_info_card.dart';
import '../../widgets/order_details/payment_method_row.dart';
import '../../widgets/order_details/rating_dialog.dart';
import '../../widgets/order_details/restaurant_card.dart';
import '../../widgets/order_details/section_header.dart';
import '../../widgets/order_details/tracking_sheet.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isDownloading = false;

  // ── حفظ صورة الفاتورة
  Future<void> _saveInvoiceScreenshot() async {
    try {
      final image = await _screenshotController.capture(pixelRatio: 3);
      if (!mounted || image == null) return;

      if (kIsWeb) {
        final blob = html.Blob([image]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.AnchorElement(href: url)
          ..setAttribute("download", "invoice.png")
          ..click();
        html.Url.revokeObjectUrl(url);
        SnackBarHelper.show(context, "✅ تم تحميل الصورة");
      } else {
        await ImageGallerySaverPlus.saveImage(image);
        SnackBarHelper.show(context, "✅ تم حفظ الصورة في المعرض");
      }
    } catch (e) {
      if (!mounted) return;
      SnackBarHelper.show(context, "❌ فشل حفظ الصورة $e");
    }
  }

  // ── مشاركة صورة الفاتورة
  Future<void> _shareInvoiceScreenshot() async {
    try {
      final image = await _screenshotController.capture(pixelRatio: 3);
      if (!mounted || image == null) return;

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(image, mimeType: 'image/png', name: 'invoice.png'),
          ],
          text: "📸 فاتورة طلبك",
        ),
      );
    } catch (e) {
      if (!mounted) return;
      SnackBarHelper.show(context, "❌ فشل مشاركة الصورة $e");
    }
  }

  // ── تحميل PDF
  Future<void> _downloadInvoice() async {
    if (!mounted) return;
    setState(() => _isDownloading = true);

    try {
      final pdfBytes = await InvoiceGenerator.generate(widget.order);
      if (!mounted) return;

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: 'invoice_${widget.order.orderNumber.replaceAll('#', '')}.pdf',
      );
    } catch (e) {
      if (!mounted) return;
      _showSnackBar("❌ حدث خطأ أثناء إنشاء الفاتورة $e", success: false);
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  void _showSnackBar(String msg, {bool success = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
        ),
        backgroundColor: success ? Colors.green[700] : Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showCancelDialog() => _showDialog(
    CancelDialog(
      showWarning: false,
      onConfirm: (reason) =>
          _showSnackBar('✅ تم إلغاء الطلب: $reason', success: true),
    ),
  );

  void _showPreparingCancelDialog() => _showDialog(
    CancelDialog(
      showWarning: true,
      onConfirm: (reason) =>
          _showSnackBar('✅ تم إلغاء الطلب: $reason', success: true),
    ),
  );

  void _showRatingDialog() => _showDialog(
    RatingDialog(
      onSubmit: (rating, comment) =>
          _showSnackBar('✅ تم إرسال التقييم: $rating نجوم', success: true),
    ),
  );

  void _showDialog(Widget dialog) {
    if (!mounted) return;
    showDialog(context: context, builder: (_) => dialog);
  }

  void _showTrackingSheet() {
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TrackingSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCancelled = widget.order.status == OrderStatus.cancelled;

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
        child: Column(
          children: [
            // ── زر خيارات الفاتورة خارج الـ Screenshot
            InvoiceOptionsCard(
              onDownloadPdf: _downloadInvoice,
              onSaveImage: _saveInvoiceScreenshot,
              onShareImage: _shareInvoiceScreenshot,
            ),
            const SizedBox(height: 10),

            // ── Screenshot فقط لمحتوى الفاتورة
            Screenshot(
              controller: _screenshotController,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.background,
                child: Column(
                  children: [
                    OrderInfoCard(order: widget.order),
                    const SizedBox(height: 15),
                    RestaurantCard(order: widget.order),
                    const SizedBox(height: 25),
                    SectionHeader(title: 'الوجبات'),
                    const SizedBox(height: 15),
                    MealsTable(items: widget.order.items),
                    const SizedBox(height: 35),
                    PaymentMethodRow(paymentMethod: widget.order.paymentMethod),
                    const SizedBox(height: 35),
                    const SectionHeader(title: 'بيانات الدفع'),
                    const SizedBox(height: 15),
                    PaymentDetails(order: widget.order),
                    const SizedBox(height: 30),
                    GrandTotalRow(total: widget.order.formattedGrandTotal),
                    const SizedBox(height: 30),
                    if (isCancelled) ...[
                      CancellationSection(order: widget.order),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),

            // ── زر الإجراءات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ActionButton(
                order: widget.order,
                onCancel: _showCancelDialog,
                onPreparingCancel: _showPreparingCancelDialog,
                onTrack: _showTrackingSheet,
                onRate: _showRatingDialog,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
