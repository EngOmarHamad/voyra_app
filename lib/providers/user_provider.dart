import '../core/common_dependencies.dart';
import '../services/local_notification_service.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  // --- دالة مساعدة داخلية لإنشاء إشعار في Firestore ---
  Future<void> _createNotification({
    required String title,
    required String body,
  }) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      await _db.collection('users').doc(uid).collection('notifications').add({
        'title': title,
        'body': body,
        'createdAt': FieldValue.serverTimestamp(),
        'isRead': false,
      });

      LocalNotificationService.showInstantNotification(
        title: title,
        body: body,
      );
    } catch (e) {
      debugPrint("Error creating notification: $e");
    }
  }

  // 1. تحديث أي حقول عامة
  Future<bool> updateUserFields(Map<String, dynamic> data) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return false;

      await _db.collection('users').doc(uid).update(data);

      // إشعار فوري
      await _createNotification(
        title: 'تحديث الحساب',
        body: 'تم تحديث بيانات ملفك الشخصي بنجاح.',
      );

      await fetchUserData();
      return true;
    } catch (e) {
      debugPrint("Error updating user fields: $e");
      return false;
    }
  }

  // 2. جلب بيانات المستخدم
  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();
    try {
      String uid = _auth.currentUser!.uid;
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

  // 3. تحديث الملف الشخصي (الاسم والبريد)
  Future<bool> updateProfile(String name, String email) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _db.collection('users').doc(uid).update({
        'name': name,
        'email': email,
      });

      await _createNotification(
        title: 'تعديل الملف الشخصي',
        body: 'تم تعديل اسم المستخدم أو البريد الإلكتروني بنجاح.',
      );

      await fetchUserData();
      return true;
    } catch (e) {
      return false;
    }
  }

  // 4. تحديث رقم الجوال
  Future<bool> updatePhoneNumber(String newPhone) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return false;

      await _db.collection('users').doc(uid).update({'phone': newPhone});

      await _createNotification(
        title: 'تغيير رقم الهاتف',
        body: 'تم تحديث رقم هاتفك المرتبط بالحساب إلى $newPhone.',
      );

      await fetchUserData();
      return true;
    } catch (e) {
      debugPrint("Error updating phone: $e");
      return false;
    }
  }

  // 5. تحديث البيانات البنكية
  Future<bool> updateBankDetails(BankModel bankData) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _db.collection('users').doc(uid).update({
        'bankDetails': bankData.toMap(),
      });

      await _createNotification(
        title: 'البيانات البنكية',
        body: 'تم تحديث معلومات حسابك البنكي بنجاح.',
      );

      await fetchUserData();
      return true;
    } catch (e) {
      debugPrint("Error updating bank details: $e");
      return false;
    }
  }

  // 6. تغيير كلمة المرور
  Future<String?> changePassword(String oldPassword, String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user == null || user.email == null) return "انتهت الجلسة";

      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      // إشعار أمني هام
      await _createNotification(
        title: 'أمن الحساب',
        body: 'لقد قمت بتغيير كلمة المرور الخاصة بك بنجاح.',
      );

      return null;
    } on FirebaseAuthException catch (e) {
      // (نفس الـ switch الخاص بالأخطاء الذي كتبناه سابقاً)
      return _handleAuthError(e.code);
    } catch (e) {
      return "فشل الاتصال بالخادم";
    }
  }

  // دالة مساعدة لتنظيم الأخطاء
  String _handleAuthError(String code) {
    switch (code) {
      case 'wrong-password':
      case 'invalid-credential':
        return "كلمة المرور القديمة غير صحيحة";
      case 'weak-password':
        return "كلمة المرور الجديدة ضعيفة";
      default:
        return "حدث خطأ غير متوقع: $code";
    }
  }
}
