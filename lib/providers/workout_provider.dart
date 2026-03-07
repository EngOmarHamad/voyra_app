import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class WorkoutProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<WorkoutModel> _workouts = [];
  bool _isLoading = true;

  List<WorkoutModel> get workouts => _workouts;
  bool get isLoading => _isLoading;

  WorkoutProvider() {
    fetchWorkouts();
  }

  // جلب البيانات
  Future<void> fetchWorkouts() async {
    _isLoading = true;
    notifyListeners();

    _db.collection('workouts').snapshots().listen((snapshot) {
      _workouts = snapshot.docs
          .map((doc) => WorkoutModel.fromDoc(doc.id, doc.data()))
          .toList();
      _isLoading = false;
      notifyListeners();
    });
  }

  // إضافة تمرين
  Future<void> addWorkout(String name, String level) async {
    await _db.collection('workouts').add({'name': name, 'level': level});
  }

  // حذف تمرين
  Future<void> deleteWorkout(String id) async {
    await _db.collection('workouts').doc(id).delete();
  }
}
