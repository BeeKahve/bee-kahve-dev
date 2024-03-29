import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/screens/cart/cart.dart';
import 'package:bee_kahve/screens/home.dart';
import 'package:bee_kahve/screens/profile/profile.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  final int currentScreen;
  final User? user; // Add currentScreen parameter

  const RootScreen({Key? key, this.currentScreen = 0, required this.user})
      : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  late int currentScreen; // Remove int currentScreen = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    currentScreen =
        widget.currentScreen; // Update currentScreen from widget parameter
    screens = [
      HomeScreen(user: widget.user),
      CartScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: AppColors.lightYellow,
        indicatorColor: AppColors.scaffoldBackgroundColor,
        elevation: 8,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              size: 32,
              color: AppColors.yellow,
            ),
            icon: Icon(
              Icons.home,
              size: 28,
              color: AppColors.textColor,
            ),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.shopping_cart,
              size: 32,
              color: AppColors.yellow,
            ),
            icon: Icon(
              Icons.shopping_cart,
              size: 28,
              color: AppColors.textColor,
            ),
            label: "Cart",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle,
              size: 32,
              color: AppColors.yellow,
            ),
            icon: Icon(
              Icons.account_circle,
              size: 28,
              color: AppColors.textColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
