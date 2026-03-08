import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> loadUser() async {
    final user = _auth.currentUser;

    if (user == null) return;

    _currentUser = await _firestoreService.getUser(user.uid);

    notifyListeners();
  }

  // تسجيل الدخول
  Future<String?> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final trimmedEmail = email.trim();
      final trimmedPassword = password.trim();

      await _auth.signInWithEmailAndPassword(
        email: trimmedEmail,
        password: trimmedPassword,
      );
      await loadUser();

      _setLoading(false);
      return null;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      print('FirebaseAuthException: code=${e.code}, message=${e.message}');
      switch (e.code) {
        case 'user-not-found':
          return 'المستخدم غير موجود. الرجاء التسجيل أولاً.';
        case 'wrong-password':
          return 'كلمة المرور غير صحيحة';
        case 'invalid-email':
          return 'البريد الإلكتروني غير صالح';
        case 'invalid-credential':
          return 'بيانات تسجيل الدخول غير صحيحة أو منتهية الصلاحية';
        default:
          return 'حدث خطأ أثناء تسجيل الدخول. الرجاء المحاولة لاحقاً.';
      }
    } catch (e) {
      _setLoading(false);
      return 'حدث خطأ أثناء الاتصال بالخادم';
    }
  }

  // تسجيل جديد
  Future<String?> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      // إنشاء المستخدم في Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      final user = UserModel(
        uid: userCredential.user!.uid,
        name: name.trim(),
        phone: phone.trim(),
        email: email.trim(),
        createdAt: Timestamp.now(),
        bankDetails: null,
      );

      await _firestoreService.createUser(user);

      _currentUser = user;
      // تخزين بيانات إضافية في Firestore

      _setLoading(false);
      return null; // التسجيل ناجح
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      print('FirebaseAuthException: code=${e.code}, message=${e.message}');
      switch (e.code) {
        case 'email-already-in-use':
          return 'البريد مستخدم مسبقاً';
        case 'weak-password':
          return 'كلمة المرور ضعيفة جداً';
        case 'invalid-email':
          return 'البريد غير صالح';
        default:
          return 'حدث خطأ أثناء إنشاء الحساب. الرجاء المحاولة لاحقاً.';
      }
    } catch (e) {
      _setLoading(false);
      return 'حدث خطأ أثناء الاتصال بالخادم';
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
