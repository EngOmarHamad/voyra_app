import '../../core/common_dependencies.dart';
import '../../models/order_model.dart';
import '../../models/order_item.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // بيانات وهمية — ستُستبدل بـ API لاحقاً
  final List<OrderModel> orders = [
    OrderModel(
      id: '1',
      userId: '',
      orderNumber: '#1256564',
      createdAt: DateTime(2025, 3, 22, 14, 0),
      status: OrderStatus.newOrder,
      restaurantName: 'مطعم دجاج تكا',
      restaurantImageUrl:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=100&auto=format&fit=crop',
      items: const [
        OrderItem(id: '1', name: 'برجر دجاج', quantity: 2, price: 200),
        OrderItem(id: '2', name: 'دجاج برياني', quantity: 1, price: 200),
        OrderItem(id: '3', name: 'دجاج مشوي', quantity: 1, price: 200),
      ],
      paymentMethod: PaymentMethod.wallet,
      deliveryFee: 200,
      tax: 200,
      adminFee: 500,
    ),
    OrderModel(
      id: '2',
      userId: '',
      orderNumber: '#1256565',
      createdAt: DateTime(2025, 3, 21, 12, 30),
      status: OrderStatus.preparing,
      restaurantName: 'مطعم دجاج تكا',
      restaurantImageUrl:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=100&auto=format&fit=crop',
      items: const [
        OrderItem(id: '4', name: 'دجاج مشوي', quantity: 2, price: 150),
      ],
      paymentMethod: PaymentMethod.creditCard,
      deliveryFee: 150,
      tax: 100,
      adminFee: 200,
    ),
    OrderModel(
      id: '3',
      userId: '',
      orderNumber: '#1256566',
      createdAt: DateTime(2025, 3, 20, 19, 0),
      status: OrderStatus.onTheWay,
      restaurantName: 'مطعم دجاج تكا',
      restaurantImageUrl:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=100&auto=format&fit=crop',
      items: const [
        OrderItem(id: '5', name: 'برجر دجاج', quantity: 1, price: 200),
        OrderItem(id: '6', name: 'دجاج برياني', quantity: 2, price: 200),
      ],
      paymentMethod: PaymentMethod.wallet,
      deliveryFee: 200,
      tax: 150,
      adminFee: 300,
    ),
    OrderModel(
      id: '4',
      userId: '',
      orderNumber: '#1256567',
      createdAt: DateTime(2025, 3, 18, 13, 0),
      status: OrderStatus.delivered,
      restaurantName: 'مطعم دجاج تكا',
      restaurantImageUrl:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=100&auto=format&fit=crop',
      items: const [
        OrderItem(id: '7', name: 'دجاج مشوي', quantity: 3, price: 150),
        OrderItem(id: '8', name: 'دجاج برياني', quantity: 1, price: 200),
      ],
      paymentMethod: PaymentMethod.cash,
      deliveryFee: 100,
      tax: 120,
      adminFee: 200,
    ),
    OrderModel(
      id: '5',
      userId: '',
      orderNumber: '#1256568',
      createdAt: DateTime(2025, 3, 15, 10, 0),
      status: OrderStatus.cancelled,
      restaurantName: 'مطعم دجاج تكا',
      restaurantImageUrl:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=100&auto=format&fit=crop',
      items: const [
        OrderItem(id: '9', name: 'برجر دجاج', quantity: 1, price: 200),
      ],
      paymentMethod: PaymentMethod.wallet,
      deliveryFee: 200,
      tax: 100,
      adminFee: 150,
      cancelReason: 'أردت تبديل الوجبة بوجبة أخرى',
      cancelDate: DateTime(2025, 10, 12),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'طلباتي',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        leading: const CustomBackButton(),
      ),
      body: _buildOrdersList(),
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderCard(orders[index]),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailScreen(order: order),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // صورة المطعم
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  order.restaurantImageUrl,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 75,
                    height: 75,
                    color: Colors.grey[200],
                    child: const Icon(Icons.fastfood, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // اسم الطلب + المطعم + السعر
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.displayTitle,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.restaurantName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      order.formattedGrandTotal,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),

              // حالة الطلب + التاريخ
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: order.status.backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status.label,
                      style: TextStyle(
                        fontSize: 11,
                        color: order.status.textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[400],
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
