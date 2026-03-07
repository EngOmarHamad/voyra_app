import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/order_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // =========================
  // Users
  // =========================

  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data()!);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  // =========================
  // Cart (السلة)
  // =========================

  Future<void> addToCart({
    required String uid,
    required Map<String, dynamic> item,
  }) async {
    await _db.collection('users').doc(uid).collection('cart').add(item);
  }

  Future<void> removeFromCart({
    required String uid,
    required String cartItemId,
  }) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(cartItemId)
        .delete();
  }

  Stream<QuerySnapshot> getCart(String uid) {
    return _db.collection('users').doc(uid).collection('cart').snapshots();
  }

  Future<void> clearCart(String uid) async {
    final cart = await _db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .get();

    for (var doc in cart.docs) {
      await doc.reference.delete();
    }
  }

  // =========================
  // Orders
  // =========================

  Future<void> createOrder({
    required String uid,
    required OrderModel order,
  }) async {
    await _db.collection('orders').doc(order.id).set(order.toMap());

    await _db
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc(order.id)
        .set(order.toMap());
  }

  Stream<QuerySnapshot> getUserOrders(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<OrderModel?> getOrder(String orderId) async {
    final doc = await _db.collection('orders').doc(orderId).get();

    if (!doc.exists) return null;

    return OrderModel.fromMap(doc.data()!);
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _db.collection('orders').doc(orderId).update({'status': status});
  }

  // =========================
  // Restaurants
  // =========================

  Stream<QuerySnapshot> getRestaurants() {
    return _db.collection('restaurants').snapshots();
  }
}
