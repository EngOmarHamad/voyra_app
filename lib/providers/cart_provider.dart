import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_item.dart';
import '../models/order_model.dart';
import '../services/firestore_service.dart';

class CartProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<OrderItem> _items = [];

  List<OrderItem> get items => _items;
  int get itemCount => _items.length;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// مجموع السعر
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  /// رسوم ثابتة مؤقتاً
  double get deliveryFee => 10;

  double get tax => subtotal * 0.05;

  double get adminFee => 2;

  double get total => subtotal + deliveryFee + tax + adminFee;

  /// إضافة للسلة
  Future<void> addToCart(OrderItem item) async {
    final existingIndex = _items.indexWhere((element) => element.id == item.id);
    debugPrint(
      "Adding to cart: ${item.name}, quantity: ${item.quantity}, price: ${item.price}",
    );
    debugPrint(
      "Current cart items: ${_items.map((e) => '${e.name} (qty: ${e.quantity})').join(', ')}",
    );
    if (existingIndex >= 0) {
      final existingItem = _items[existingIndex];

      _items[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + item.quantity,
      );
    } else {
      _items.add(item);
    }

    notifyListeners();
  }

  /// إزالة من السلة
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  /// تغيير الكمية
  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);

    if (index == -1) return;

    if (quantity <= 0) {
      removeItem(id);
      return;
    }

    _items[index] = _items[index].copyWith(quantity: quantity);

    notifyListeners();
  }

  /// تفريغ السلة
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// إنشاء طلب
  Future<String?> createOrder({
    required String restaurantName,
    required String restaurantImage,
    required PaymentMethod paymentMethod,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = _auth.currentUser;

      if (user == null) {
        _isLoading = false;
        notifyListeners();
        return "يجب تسجيل الدخول";
      }

      final orderId = DateTime.now().millisecondsSinceEpoch.toString();

      final order = OrderModel(
        id: orderId,
        userId: user.uid,
        orderNumber: orderId.substring(orderId.length - 6),
        createdAt: DateTime.now(),
        status: OrderStatus.newOrder,
        restaurantName: restaurantName,
        restaurantImageUrl: restaurantImage,
        items: _items,
        paymentMethod: paymentMethod,
        deliveryFee: deliveryFee,
        tax: tax,
        adminFee: adminFee,
      );

      await _firestoreService.createOrder(uid: user.uid, order: order);

      clearCart();

      _isLoading = false;
      notifyListeners();

      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      return "حدث خطأ أثناء إنشاء الطلب";
    }
  }
}
