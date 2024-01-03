import 'dart:developer';
import 'package:bee_kahve/screens/products/product_details.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/menu_model.dart';
import 'package:bee_kahve/models/menu_product_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late TextEditingController searchTextController;
  late MenuModel coffeeMenu;
  late List<MenuProductModel> displayedProducts;

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
    coffeeMenu = MenuModel(productCount: 0, menuProducts: []);
    displayedProducts = [];
    fetchMenu();
  }

  void searchCoffee(String searchTerm) {
    setState(() {
      displayedProducts = coffeeMenu.menuProducts
          .where((product) => product.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchMenu() async {
    try {
      var response =
          await http.get(Uri.parse('http://51.20.117.162:8000/get_menu'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        List<MenuProductModel> menuProducts = [];
        if (jsonData['menuProducts'] is List) {
          menuProducts = List<MenuProductModel>.from(jsonData['menuProducts']
              .map((item) => MenuProductModel(
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

        setState(() {
          coffeeMenu = menu;
          displayedProducts = coffeeMenu.menuProducts;
        });
      } else {
        print('Failed to load menu data: ${response.statusCode}');
        // Handle the error if the server did not return a 200 OK response
      }
    } catch (e) {
      print('Error fetching menu data: $e');
      // Handle other exceptions, such as network issues
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        "Coffee Menu",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
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
                      displayedProducts = coffeeMenu.menuProducts;
                    });
                  },
                  child: const Icon(Icons.clear),
                ),
                contentPadding: const EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: AppColors.lightYellow,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: AppColors.lightYellow,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
              if (value.isEmpty) {
                // If the text is cleared, reset to the entire menu
                setState(() {
                  displayedProducts = coffeeMenu.menuProducts;
                });
              }
            },
            onSubmitted: (value) {
              searchCoffee(value);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: displayedProducts.isEmpty && searchTextController.text.isNotEmpty
                ? const Center(
                    child: Text(
                      'You entered the wrong coffee name',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: displayedProducts.length,
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
                              builder: (context) => ProductDetailsScreen(productId: displayedProducts[index].productId),
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
                                  CachedNetworkImage(
                                    imageUrl: displayedProducts[index].photoPath,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.width / 4.0,
                                  ),
                                  Text(
                                    displayedProducts[index].name,
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
          ),
        ],
      ),
    ),
  );
}

}
