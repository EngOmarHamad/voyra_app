import '../../core/common_dependencies.dart';
import '../../widgets/basket/basket_empty_state.dart';
import '../../widgets/basket/basket_item_card.dart';
import '../../widgets/basket/basket_order_summary.dart';
import '../../widgets/basket/basket_bottom_navbar.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  // Dummy data for the basket
  final List<Map<String, dynamic>> _items = [
    {
      'meal': Meal(
        name:
            'برجر لحم كلاسيكبرجر لحم كلاسيكبرجر لحم كلاسيكبرجر لحم كلاسيكبرجر لحم كلاسيكبرجر لحم كلاسيكبرجر لحم كلاسيكبرجر لحم كلاسيك',
        price: 45.0,
        image:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
      ),
      'quantity': 2,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'بيتزا بيتاروني',
        price: 65.0,
        image:
            'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
      ),
      'quantity': 1,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'بطاطس مقلية',
        price: 15.0,
        image:
            'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=500',
      ),
      'quantity': 1,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'برجر لحم كلاسيك',
        price: 45.0,
        image:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
      ),
      'quantity': 2,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'بيتزا بيتاروني',
        price: 65.0,
        image:
            'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
      ),
      'quantity': 1,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'بطاطس مقلية',
        price: 15.0,
        image:
            'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=500',
      ),
      'quantity': 1,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'برجر لحم كلاسيك',
        price: 45.0,
        image:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
      ),
      'quantity': 2,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'بيتزا بيتاروني',
        price: 65.0,
        image:
            'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
      ),
      'quantity': 1,
      'note': '',
    },
    {
      'meal': Meal(
        name: 'بطاطس مقلية',
        price: 15.0,
        image:
            'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=500',
      ),
      'quantity': 1,
      'note': '',
    },
  ];

  double get _subtotal {
    return _items.fold(
      0,
      (sum, item) => sum + (item['meal'].price * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: _items.isEmpty
          ? const BasketEmptyState()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              children: [
                ..._items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return BasketItemCard(
                    meal: item['meal'] as Meal,
                    quantity: item['quantity'] as int,
                    note: item['note'] as String,
                    onAdd: () => setState(() => _items[index]['quantity']++),
                    onRemove: () {
                      if (_items[index]['quantity'] > 1) {
                        setState(() => _items[index]['quantity']--);
                      } else {
                        setState(() => _items.removeAt(index));
                      }
                    },
                    onDelete: () => setState(() => _items.removeAt(index)),
                    onNoteChanged: (value) => _items[index]['note'] = value,
                  );
                }),
                const SizedBox(height: 10),
                BasketOrderSummary(subtotal: _subtotal),
                const SizedBox(height: 10),
              ],
            ),
      bottomNavigationBar: _items.isEmpty
          ? null
          : BasketBottomNavbar(
              onCheckout: () => Navigator.pushNamed(context, '/checkout'),
            ),
    );
  }
}
