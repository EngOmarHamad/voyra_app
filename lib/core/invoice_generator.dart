import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/order_model.dart';

/// مولّد فاتورة PDF من بيانات الطلب
class InvoiceGenerator {
  static Future<Uint8List> generate(OrderModel order) async {
    final pdf = pw.Document();
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Tajawal-Regular.ttf"),
    );
    final arabicFontBold = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Tajawal-Bold.ttf"),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(base: arabicFont, bold: arabicFontBold),
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // ── العنوان الرئيسي ─────────────────────────────────────────
                _buildHeader(order),
                pw.SizedBox(height: 24),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 16),

                // ── بيانات الطلب ────────────────────────────────────────────
                _buildOrderInfo(order),
                pw.SizedBox(height: 20),

                // ── جدول الوجبات ────────────────────────────────────────────
                _buildMealsTable(order),
                pw.SizedBox(height: 20),

                // ── بيانات الدفع ────────────────────────────────────────────
                _buildPaymentSummary(order),
                pw.SizedBox(height: 24),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 12),

                // ── تذييل ───────────────────────────────────────────────────
                _buildFooter(),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  static pw.Widget _buildHeader(OrderModel order) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'فاتورة طلب',
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('CE0045'),
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              order.restaurantName,
              style: pw.TextStyle(fontSize: 13, color: PdfColors.grey700),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              order.orderNumber,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'الحالة: ${order.status.label}',
              style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  // ── بيانات الطلب ────────────────────────────────────────────────────────────
  static pw.Widget _buildOrderInfo(OrderModel order) {
    final d = order.createdAt;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}  '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        children: [
          _infoCell('رقم الطلب', order.orderNumber),
          pw.SizedBox(width: 40),
          _infoCell('تاريخ الطلب', dateStr),
          pw.SizedBox(width: 40),
          _infoCell('طريقة الدفع', order.paymentMethod.label),
        ],
      ),
    );
  }

  static pw.Widget _infoCell(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 3),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  // ── جدول الوجبات ────────────────────────────────────────────────────────────
  static pw.Widget _buildMealsTable(OrderModel order) {
    const headerStyle = pw.TextStyle(color: PdfColors.white);

    return pw.TableHelper.fromTextArray(
      headers: ['اسم الوجبة', 'الكمية', 'سعر الوحدة', 'الإجمالي'],
      data: order.items
          .map(
            (item) => [
              item.name,
              item.quantity.toString(),
              item.formattedPrice,
              item.formattedTotal,
            ],
          )
          .toList(),
      headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('CE0045')),
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontWeight: pw.FontWeight.bold,
        fontSize: 11,
      ),
      cellStyle: const pw.TextStyle(fontSize: 11),
      rowDecoration: const pw.BoxDecoration(color: PdfColors.white),
      oddRowDecoration: pw.BoxDecoration(color: PdfColors.grey50),
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
    );
  }

  // ── ملخص الدفع ──────────────────────────────────────────────────────────────
  static pw.Widget _buildPaymentSummary(OrderModel order) {
    return pw.Align(
      alignment: pw.Alignment.centerLeft,
      child: pw.Container(
        width: 220,
        child: pw.Column(
          children: [
            _summaryRow('الإجمالي الفرعي', order.formattedSubtotal),
            _summaryRow('سعر التوصيل', order.formattedDeliveryFee),
            _summaryRow('الضريبة المضافة', order.formattedTax),
            _summaryRow('نسبة الإدارة', order.formattedAdminFee),
            pw.Divider(color: PdfColors.grey400),
            _summaryRow(
              'الإجمالي الكلي',
              order.formattedGrandTotal,
              isBold: true,
              highlight: true,
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _summaryRow(
    String label,
    String value, {
    bool isBold = false,
    bool highlight = false,
  }) {
    final style = isBold
        ? pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)
        : const pw.TextStyle(fontSize: 11);

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: highlight ? PdfColor.fromHex('FCE4EC') : null,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: style),
          pw.Text(value, style: style),
        ],
      ),
    );
  }

  // ── Footer ──────────────────────────────────────────────────────────────────
  static pw.Widget _buildFooter() {
    return pw.Center(
      child: pw.Text(
        'شكراً لاستخدامك تطبيق Voyra',
        style: pw.TextStyle(fontSize: 11, color: PdfColors.grey500),
      ),
    );
  }
}
