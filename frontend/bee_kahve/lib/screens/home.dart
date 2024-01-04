import 'package:bee_kahve/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
  }

  String getCoffeesNeededForReward() {
    const coffeesForReward = 5; 
    if (coffeesForReward - (widget.user?.loyaltyCount ?? 0) > 0) {
      return "${coffeesForReward - (widget.user?.loyaltyCount ?? 0)} coffees left to get a reward drink";
    }
    return "Congratulations! You get a reard drink";
  }

  @override
  Widget build(BuildContext context) {
    int loyaltyCount = widget.user?.loyaltyCount ?? 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Text(
              "Bee'",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.yellow,
              ),
            ),
            Text(
              " Kahve",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: AppColors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuScreen(user: widget.user),
                  ),
                );
              },
              child: const Text(
                "Menu",
                style: TextStyle(color: AppColors.darkColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Other Widgets for Home Screen)
              const Text(
                "Campaigns",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                getCoffeesNeededForReward(),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.coffee,
                      size: 60,
                      color: loyaltyCount > i
                          ? AppColors.yellow
                          : AppColors.textColor,
                    ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Have you tried our Affagato coffee?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Image.asset(
                "assets/images/try-coffee.png",
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
