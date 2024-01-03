import 'dart:convert';
import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/menu_product_model.dart';
import 'package:bee_kahve/models/product_model.dart';
import 'package:bee_kahve/root.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class Coffee {
  final int id;
  final String name;
  final String photoPath;
  final double price;
  final String? milkType;
  final bool? extraShot;
  final bool? decaf;
  final String? size;

  Coffee(
      {required this.id,
      required this.name,
      required this.photoPath,
      required this.price,
      this.milkType,
      this.extraShot,
      this.decaf,
      required this.size
      // Add other necessary fields
      });
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool? _isChecked;
  bool? _isCheckedDecaf;
  String? _dropdownValue = "Milk Options";
  String? _selectedMilkType;
  String? _selectedSize;
  late Future<Map<String, dynamic>> productDetails;

  @override
  void initState() {
    super.initState();
    productDetails = fetchProductDetails();
  }

  Future<Map<String, dynamic>> fetchProductDetails() async {
    final response = await http.get(
      Uri.parse(
          'http://51.20.117.162:8000/get_product?product_id=${widget.productId}'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  Future<void> _addCart(product) async {
    // Create a product object with selected options
    Coffee productToAdd = Coffee(
      id: widget.productId,
      name: product?['coffee_name'] ?? '',
      photoPath: product?['photo_path'] ?? '',
      price: product?['price'] ?? 0.0,
      milkType: _selectedMilkType,
      extraShot: _isChecked,
      decaf: _isCheckedDecaf,
      size: _selectedSize,
    );

    // Add the product to the cart using the cart provider
    CartProvider cartProvider = CartProvider();
    cartProvider.addToCart(productToAdd);
    Navigator.pop(context);
    Navigator.pop(context);
    // Additional logic (e.g., show a confirmation message)
  }

  void dropdownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  Widget buildIngredientText(String text, bool isVisible) {
    return isVisible
        ? Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: AppColors.textColor),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget coffeeDetailsText(String text, bool isVisible) {
    return isVisible
        ? Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textColor),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: productDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while fetching data
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final product = snapshot.data;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(
                            Icons.keyboard_backspace,
                            size: 32,
                          ),
                        ),
                        Text(
                          product?['coffee_name'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: AppColors.textColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CachedNetworkImage(
                      imageUrl: product?['photo_path'] ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: double.infinity, // Set image width to full width
                      height: MediaQuery.of(context).size.width / 2.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Ratings",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: AppColors.textColor),
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: AppColors.yellow,
                          ),
                          Text(product?['rate']?.toString() ?? ''),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Coffee Details",
                      style: TextStyle(color: AppColors.textColor),
                    ),
                    buildIngredientText(
                        "Contains milk", product?['contains_milk'] == true),
                    buildIngredientText("Contains chocolate syrup",
                        product?['contains_chocolate_syrup'] == true),
                    buildIngredientText("Contains white chocolate syrup",
                        product?['contains_white_chocolate_syrup'] == true),
                    buildIngredientText("Contains caramel syrup",
                        product?['contains_caramel_syrup'] == true),
                    buildIngredientText(
                        "Contains sugar", product?['contains_sugar'] == true),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Extra shot",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: AppColors.textColor),
                        ),
                        Checkbox(
                            value: _isChecked ?? false,
                            activeColor: AppColors.yellow,
                            onChanged: (newBool) {
                              setState(() {
                                _isChecked = newBool;
                              });
                            }),
                        const Text(
                          "Decaf",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: AppColors.textColor),
                        ),
                        Checkbox(
                            value: _isCheckedDecaf ?? false,
                            activeColor: AppColors.yellow,
                            onChanged: (newBool) {
                              setState(() {
                                _isCheckedDecaf = newBool;
                              });
                            }),
                      ],
                    ),
                    if (product?['contains_milk'] == true)
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                                value: "Milk Options",
                                enabled: false,
                                child: Text(
                                  "Milk Options",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: AppColors.textColor),
                                )),
                            DropdownMenuItem(
                              value: "Whole Milk",
                              child: Text(
                                "Whole Milk",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Reduced Fat Milk",
                              child: Text(
                                "Reduced Fat Milk",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Lactose Free Milk",
                              child: Text(
                                "Lactose Free Milk",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Oat Milk",
                              child: Text(
                                "Oat Milk",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Almond Milk",
                              child: Text(
                                "Almond Milk",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.textColor),
                              ),
                            ),
                          ],
                          value: _dropdownValue,
                          onChanged: (selectedValue) {
                            setState(() {
                              _selectedMilkType = selectedValue;
                              dropdownCallBack(selectedValue);
                            });
                          },
                          iconSize: 32,
                          isExpanded: true,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedSize = 'small';
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _selectedSize == 'small'
                                ? AppColors.yellow
                                : null,
                          ),
                          child: Text(
                            "Small\n${product?['price']?.toStringAsFixed(2) ?? ''}",
                            style: const TextStyle(color: AppColors.textColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedSize = 'medium';
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _selectedSize == 'medium'
                                ? AppColors.yellow
                                : null,
                          ),
                          child: Text(
                            "Medium\n${(product?['price'] * 1.3)?.toStringAsFixed(2)}",
                            style: const TextStyle(color: AppColors.textColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedSize = 'large';
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _selectedSize == 'large'
                                ? AppColors.yellow
                                : null,
                          ),
                          child: Text(
                            "Large\n${(product?['price'] * 1.7)?.toStringAsFixed(2)}",
                            style: const TextStyle(color: AppColors.textColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () async {
                          if (_selectedSize == null ||
                              _selectedSize == 'not selected' ||
                              _selectedMilkType == null ||
                              _selectedMilkType == 'Milk Options') {
                            // Display an error message (you can use a SnackBar or any other suitable widget)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please choose both milk type and size before adding to the cart.'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          } else {
                            // The user has chosen both milk type and size, proceed to add the product to the cart
                            await _addCart(product);
                          }
                        },
                        child: const Text("Add to Cart",
                            style: TextStyle(color: AppColors.darkColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
