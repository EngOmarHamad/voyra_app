import '../core/common_dependencies.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  // دالة عامة لتحديث أي حقول في مستند المستخدم
  Future<bool> updateUserFields(Map<String, dynamic> data) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return false;

      await _db.collection('users').doc(uid).update(data);

      // تحديث البيانات محلياً بعد النجاح
      await fetchUserData();
      return true;
    } catch (e) {
      debugPrint("Error updating user fields: $e");
      return false;
    }
  }

  // جلب بيانات المستخدم من Firestore
  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      String uid = _auth.currentUser!.uid;
      debugPrint("Fetching user data for UID: $uid");
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();

      if (doc.exists) {
        _currentUser = UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint("Error fetching user: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // تحديث البيانات الأساسية (الاسم، البريد)
  Future<bool> updateProfile(String name, String email) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _db.collection('users').doc(uid).update({
        'name': name,
        'email': email,
      });
      await fetchUserData(); // تحديث البيانات محلياً
      return true;
    } catch (e) {
      return false;
    }
  }

  // تحديث رقم الجوال في Firestore فقط (بعد التحقق بنجاح)
  Future<bool> updatePhoneNumber(String newPhone) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return false;

      await _db.collection('users').doc(uid).update({'phone': newPhone});

      await fetchUserData(); // تحديث البيانات محلياً للمزامنة
      return true;
    } catch (e) {
      debugPrint("Error updating phone: $e");
      return false;
    }
  }

  // تحديث البيانات البنكية
  Future<bool> updateBankDetails(BankModel bankData) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _db.collection('users').doc(uid).update({
        'bankDetails': bankData.toMap(),
      });
      await fetchUserData();
      return true;
    } catch (e) {
      debugPrint("Error updating bank details: $e");
      return false;
    }
  }

  Future<String?> changePassword(String oldPassword, String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user == null || user.email == null)
        return "جلسة العمل انتهت، يرجى تسجيل الدخول مجدداً";

      // 1. إعادة التحقق من كلمة المرور القديمة
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // 2. تحديث كلمة المرور الجديدة
      await user.updatePassword(newPassword);

      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error Code: ${e.code}");

      // تحويل الأكواد إلى رسائل عربية
      switch (e.code) {
        case 'wrong-password':
        case 'invalid-credential':
          return "كلمة المرور القديمة التي أدخلتها غير صحيحة";
        case 'weak-password':
          return "كلمة المرور الجديدة ضعيفة جداً، يرجى اختيار كلمة أقوى";
        case 'user-not-found':
          return "لم يتم العثور على حساب المستخدم";
        case 'too-many-requests':
          return "محاولات كثيرة خاطئة، تم حظر العمليات مؤقتاً.. حاول لاحقاً";
        case 'requires-recent-login':
          return "لأمانك، يرجى تسجيل الخروج والتشجيل مرة أخرى لتغيير كلمة المرور";
        case 'billing-not-enabled':
          return "يوجد مشكلة في خدمات التحقق (الفوترة)، يرجى التواصل مع الدعم";
        default:
          return "حدث خطأ غير متوقع: ${e.code}"; // نعرض الكود فقط للمطور وليس الرسالة الطويلة
      }
    } catch (e) {
      return "فشل الاتصال بالخادم، تأكد من جودة الإنترنت";
    }
  }
}
