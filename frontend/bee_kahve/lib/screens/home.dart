import 'dart:developer';
import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:bee_kahve/screens/products/product_details.dart';
import 'dart:convert';
import 'package:bee_kahve/models/menu_product_mode.dart';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';

class HomeScreen extends StatefulWidget {
  final User? user;
  const HomeScreen({Key? key, this.user}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchTextController;
  late MenuModel coffeeMenu;
  User? user;
  bool _isMounted = false;

  Future<MenuModel> getMenu() async {
  try {
    var response = await http.get(Uri.parse('http://51.20.117.162:8000/get_menu'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      List<MenuProductModel> menuProducts = [];
      if (jsonData['menuProducts'] is List) {
        menuProducts = List<MenuProductModel>.from(jsonData['menuProducts'].map((item) => MenuProductModel(
          productId: item['product_id'],
          name: item['name'],
          photoPath: item['photo_path'],
          rate: item['rate'],
          price: item['price'],
        )));
      }

      MenuModel menu = MenuModel(
        menuProducts: menuProducts,
        productCount: jsonData['product_count'],
      );

      print(menu.productCount);
      return menu;
    } else {
      // Handle the error if the server did not return a 200 OK response
      print('Failed to load menu data: ${response.statusCode}');
      return MenuModel(productCount: 0, menuProducts: []); // Return an empty menu model or handle it as needed
    }
  } catch (e) {
    // Handle other exceptions, such as network issues
    print('Error fetching menu data: $e');
    return MenuModel(productCount: 0, menuProducts: []); // Return an empty menu model or handle it as needed
  }
}

  int getCoffeesNeededForReward() {
    const coffeesForReward = 5; // Set the number of coffees needed for a reward
    return coffeesForReward - (user?.loyaltyCount ?? 0);
  }
  
  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
    coffeeMenu = MenuModel(productCount: 0, menuProducts: []);
    fetchMenu();  // Make sure searchTextController is initialized before using it.
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> fetchMenu() async {
    try {
      MenuModel menu = await getMenu();
      if (mounted) {
        setState(() {
          coffeeMenu = menu;
        });
      }
    } catch (e) {
      print('Error fetching menu data: $e');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    int loyaltyCount = widget.user?.loyaltyCount ?? 0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              Text(
                "Bee",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellow),
              ),
              Text(
                "Kahve",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightYellow,
                    hintText: "Search coffee",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            searchTextController.clear();
                            FocusScope.of(context).unfocus();
                          });
                        },
                        child: const Icon(Icons.clear)),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                          color: AppColors.lightYellow, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                          color: AppColors.lightYellow, width: 2),
                    ),
                  ),
                  onSubmitted: (value) {
                    log("value of the controller text: ${searchTextController.text}");
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Campaigns",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: AppColors.textColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                   "${getCoffeesNeededForReward()} coffees left to get a reward drink",
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: AppColors.textColor),
                )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        Icons.coffee,
                        size: 40,
                        color: loyaltyCount > i
                            ? AppColors.yellow
                            : AppColors.textColor,
                      ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Coffee Menu",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: AppColors.textColor),
                ),

                GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: coffeeMenu.productCount,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(productId: coffeeMenu.menuProducts[index].productId),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: AppColors.yellow,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  coffeeMenu.menuProducts[index].photoPath,
                                  width:
                                      MediaQuery.of(context).size.width / 4.0,
                                  height: MediaQuery.of(context).size.width / 4.0,
                                ),
                                Text(
                                  coffeeMenu.menuProducts[index].name,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
