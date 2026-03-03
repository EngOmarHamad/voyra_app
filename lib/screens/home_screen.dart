import '../core/common_dependencies.dart';
import 'restaurants/restaurants_screen.dart';
import 'settings_screen.dart';
import 'workouts_screen.dart';
import 'notifications_page.dart';
import 'search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  late final List<Widget> _screens = [
    _homeContent(),
    const WorkoutsScreen(),
    const SettingsPage(),
    const RestaurantsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.background,
      body: _screens[_selectedIndex],
      appBar: _buildAppBar(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }

  PreferredSizeWidget _restaurantsAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: DrawerMenuButton(),
      title: Text(
        'قائمة المطاعم',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.cairo().fontFamily,
        ),
      ),
      actions: [CartButton()],
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    switch (_selectedIndex) {
      case 0:
        return null; // 👈 الهوم ما فيه AppBar
      case 3:
        return _restaurantsAppBar();
      case 1:
        return _workoutsAppBar();
      default:
        return _defaultAppBar();
    }
  }

  PreferredSizeWidget _defaultAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: DrawerMenuButton(),
      title: Image.asset(
        'assets/images/logo.png',
        height: 40,
        color: AppColors.primary,
      ),
      centerTitle: true,
    );
  }

  PreferredSizeWidget _workoutsAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: DrawerMenuButton(),
      title: Text(
        'التمارين',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.cairo().fontFamily,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _homeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildPromoBanner(),
          _buildSportsSection(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // --- Widgets البناء ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 0),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر الـ Drawer
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface.withValues(
                    alpha: 0.25,
                  ), // 👈 بوردر خفيف
                  width: 1,
                ),
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.surface.withValues(alpha: 0.1),
                child: const FaIcon(
                  FontAwesomeIcons.barsStaggered,
                  color: AppColors.surface,
                  size: 22,
                ),
              ),
            ),
          ),

          // اللوجو (يفضل استخدام اللوجو الأبيض هنا)
          Image.asset(
            'assets/images/logo.png',
            height: 50,
            color: AppColors.primary,
          ),

          // البحث والإشعارات
          Row(
            children: [
              _headerIconButton(FontAwesomeIcons.magnifyingGlass, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              }),
              const SizedBox(width: 10),
              _headerIconButton(FontAwesomeIcons.bell, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.surface.withValues(alpha: 0.25), // 👈 بوردر خفيف
            width: 1,
          ),
        ),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.surface.withValues(alpha: 0.1),
          child: FaIcon(icon, color: AppColors.surface, size: 20),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color.fromARGB(255, 126, 0, 42)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            height: 120,
            width: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(width: 0); // حتى ما يترك فراغ
            },
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // مهم حتى ما يكبر
              children: [
                const Text(
                  "ابدأ رحلتك نحو اللياقة الآن",
                  style: TextStyle(
                    color: AppColors.surface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 10),

                // 👇 نخلي الزر بحجمه الطبيعي
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      minimumSize: const Size(0, 36), // 👈 يقلل الارتفاع
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "ابدأ الآن",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportsSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "أنواع الرياضة",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "المزيد",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              _buildSportItem(FontAwesomeIcons.dumbbell),
              _buildSportItem(FontAwesomeIcons.bicycle),
              _buildSportItem(FontAwesomeIcons.personRunning),
              _buildSportItem(FontAwesomeIcons.handFist),
              _buildSportItem(FontAwesomeIcons.personSwimming),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSportItem(IconData icon) {
    return Container(
      width: 75,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 5),
        ],
      ),
      child: Center(child: FaIcon(icon, size: 30, color: AppColors.primary)),
    );
  }
}
