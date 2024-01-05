// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/line_items_model.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/root.dart';
import 'package:bee_kahve/screens/cart/payment.dart';
import 'package:flutter/material.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:http/http.dart' as http;

class CartBottomSheetWidget extends StatefulWidget {
  final User? user;
  final bool isReward;
  const CartBottomSheetWidget(
      {Key? key, required this.user, this.isReward = false})
      : super(key: key);
  @override
  State<CartBottomSheetWidget> createState() => _CartBottomSheetWidget();
}

class _CartBottomSheetWidget extends State<CartBottomSheetWidget> {
  CartProvider cartProvider = CartProvider();
  String calculateTotal() {
    int total = 0;
    for (int quantity in cartProvider.cartItems.values.toList()) {
      total += quantity;
    }
    return total.toString();
  }

  String calculatePrice(bool isReward) {
    if (isReward) {
      return 0.toStringAsFixed(2);
    }
    double total = 0;
    for (Coffee product in cartProvider.cartItems.keys.toList()) {
      total += product.price * cartProvider.cartItems[product]!;
    }
    return total.toStringAsFixed(2);
  }

  Future<void> _placeOrder() async {
    FocusScope.of(context).unfocus();
    CartProvider cartProvider = CartProvider();
    List<Map<String, dynamic>> listItems = [];
    List<Coffee> lineItems = [];
    for (Coffee product in cartProvider.cartItems.keys) {
      for (int i = 0; i < cartProvider.cartItems[product]!; i++) {
        lineItems.add(product);
        listItems.add({
          "product_id": product.id,
          "name": product.name,
          "photo_path": product.photoPath,
          "price": 0,
          "size_choice": product.sizeChoice,
          "milk_choice": product.milkChoice,
          "extra_shot_choice": product.extraShotChoice ?? true,
          "caffein_choice": product.caffeineChoice ?? true,
        });
      }
    }

    final Map<String, dynamic> requestBody = {
      'customer_id': widget.user?.customerId,
      'line_items': listItems,
    };

    try {
      final response = await http.post(
        Uri.parse('http://51.20.117.162:8000/place_order'),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          widget.user?.loyaltyCount -= 5;
          print("Order placed successfully");
          print("Message: ${jsonResponse['message']}");
          cartProvider.clearCart();
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RootScreen(currentScreen: 2, user: widget.user)));
        } else {
          print("Order placement failed. Message: ${jsonResponse['message']}");
        }
      } else {
        print('Order placement failed: Status code: ${response.statusCode}');
        // Handle the error if the server did not return a 200 OK response
      }
    } catch (e) {
      print('Error during order placement: $e');
      // Handle other exceptions, such as network issues
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(
            width: 1,
          ),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${calculateTotal()} Items",
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.textColor,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      "${calculatePrice(widget.isReward)}\₺",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.isReward) {
                    await _placeOrder();
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PaymentPage(user: widget.user)));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  backgroundColor: AppColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(
                    color: AppColors.darkColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
