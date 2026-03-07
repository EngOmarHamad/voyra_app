import 'package:provider/provider.dart';

import '../../core/common_dependencies.dart';
import '../../widgets/basket/basket_empty_state.dart';
import '../../widgets/basket/basket_item_card.dart';
import '../../widgets/basket/basket_order_summary.dart';
import '../../widgets/basket/basket_bottom_navbar.dart';
import '../../providers/cart_provider.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'سلة التسوق',
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: const CustomBackButton(),
      ),
      body: cart.items.isEmpty
          ? const BasketEmptyState()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              children: [
                ...cart.items.map((item) {
                  return BasketItemCard(
                    meal: Meal(
                      name: item.name,
                      price: item.price,
                      image: item.image ?? '',
                    ),
                    quantity: item.quantity,
                    note: '',
                    onAdd: () {
                      cart.updateQuantity(item.id, item.quantity + 1);
                    },
                    onRemove: () {
                      cart.updateQuantity(item.id, item.quantity - 1);
                    },
                    onDelete: () {
                      cart.removeItem(item.id);
                    },
                    onNoteChanged: (value) {},
                  );
                }),

                const SizedBox(height: 10),

                BasketOrderSummary(subtotal: cart.subtotal),

                const SizedBox(height: 10),
              ],
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : BasketBottomNavbar(
              onCheckout: () => Navigator.pushNamed(context, '/checkout'),
            ),
    );
  }
}
