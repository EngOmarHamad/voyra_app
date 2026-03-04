import 'package:voyra_app/core/common_dependencies.dart';

class SnackBarHelper {
  static void show(BuildContext context, String msg, {bool success = false}) {
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
}
