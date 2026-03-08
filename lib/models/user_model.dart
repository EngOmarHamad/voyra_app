import 'package:cloud_firestore/cloud_firestore.dart';

import 'bank_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final Timestamp createdAt;
  final BankModel? bankDetails;
  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.bankDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid']?.toString() ?? '',
      name: map['name'] ?? 'مستخدم جديد',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      bankDetails: map['bankDetails'] != null
          ? BankModel.fromMap(map['bankDetails'])
          : null,
    );
  }
}
