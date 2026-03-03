import '../../core/common_dependencies.dart';
import '../../models/order_item.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<OrderItem> orders = const [
    OrderItem(
      id: '1',
      mealName: 'وجبة دجاج تكا',
      restaurantName: 'مطعم الدجاج الملكي',
      price: '500 ريال',
      date: '22/3/2025  2:00م',
      imageUrl:
          'https://images.unsplash.com/photo-1594000108821-4202167d5308?q=80&w=200&auto=format&fit=crop',
      status: OrderStatus.newOrder,
    ),
    OrderItem(
      id: '2',
      mealName: 'وجبة دجاج تكا',
      restaurantName: 'مطعم الدجاج الملكي',
      price: '500 ريال',
      date: '22/3/2025  2:00م',
      imageUrl:
          'https://images.unsplash.com/photo-1594000108821-4202167d5308?q=80&w=200&auto=format&fit=crop',
      status: OrderStatus.preparing,
    ),
    OrderItem(
      id: '3',
      mealName: 'وجبة دجاج تكا',
      restaurantName: 'مطعم الدجاج الملكي',
      price: '500 ريال',
      date: '22/3/2025  2:00م',
      imageUrl:
          'https://images.unsplash.com/photo-1594000108821-4202167d5308?q=80&w=200&auto=format&fit=crop',
      status: OrderStatus.onTheWay,
    ),
    OrderItem(
      id: '4',
      mealName: 'وجبة دجاج تكا',
      restaurantName: 'مطعم الدجاج الملكي',
      price: '500 ريال',
      date: '22/3/2025  2:00م',
      imageUrl:
          'https://images.unsplash.com/photo-1594000108821-4202167d5308?q=80&w=200&auto=format&fit=crop',
      status: OrderStatus.delivered,
    ),
    OrderItem(
      id: '5',
      mealName: 'وجبة دجاج تكا',
      restaurantName: 'مطعم الدجاج الملكي',
      price: '500 ريال',
      date: '22/3/2025  2:00م',
      imageUrl:
          'https://images.unsplash.com/photo-1594000108821-4202167d5308?q=80&w=200&auto=format&fit=crop',
      status: OrderStatus.cancelled,
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
      itemBuilder: (context, index) {
        return _buildOrderCard(orders[index]);
      },
    );
  }

  Widget _buildOrderCard(OrderItem order) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderDetailScreen()),
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
              // Right Section: Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  order.imageUrl,
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
              // Middle Section: Name, Restaurant, Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.mealName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
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
                    order.price,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),

              const Spacer(),
              // Left Section: Status & Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                spacing: 30,
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
                  Text(
                    order.date,
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
