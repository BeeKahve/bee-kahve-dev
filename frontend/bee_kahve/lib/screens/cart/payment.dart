// ignore_for_file: use_build_context_synchronously

import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/line_items_model.dart';
import 'package:bee_kahve/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:bee_kahve/consts/validator.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentPage extends StatefulWidget {
  final User? user;
  const PaymentPage({Key? key, required this.user}) : super(key: key);
  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  late final TextEditingController _cardNumberController;
  late final TextEditingController _dateController;
  late final TextEditingController _cvvController;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _cardNumberController = TextEditingController();
    _dateController = TextEditingController();
    _cvvController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _cardNumberController.dispose();
      _dateController.dispose();
      _cvvController.dispose();
      super.dispose();
    }
  }

  Future<void> _pay() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      CartProvider cartProvider = CartProvider();
      List<Map<String, dynamic>> listItems = [];
      for (Coffee product in cartProvider.cartItems.keys) {
        for (int i = 0; i < cartProvider.cartItems[product]!; i++) {
          listItems.add({
            "product_id": product.id,
            "name": product.name,
            "photo_path": product.photoPath,
            "price": product.price,
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
            print("Order placed successfully");
            print("Message: ${jsonResponse['message']}");
            cartProvider.clearCart();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RootScreen(currentScreen: 2, user: widget.user)));
          } else {
            print(
                "Order placement failed. Message: ${jsonResponse['message']}");
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: "#### #### #### ####",
                    )
                  ],
                  decoration: const InputDecoration(
                    hintText: "Card Number",
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  validator: (value) {
                    return MyValidators.cardNumberValidator(value);
                  },
                ),
                const SizedBox(height: 16.0), // Add vertical spacing if needed
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: "##/##",
                            filter: {
                              '#': RegExp(r'[0-9]'),
                            },
                          ),
                        ],
                        decoration: const InputDecoration(
                          hintText: "Expiration Date",
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          return MyValidators.dateValidator(value);
                        },
                      ),
                    ),
                    SizedBox(width: 16.0), // Add horizontal spacing if needed
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        decoration: InputDecoration(
                          hintText: "CVV",
                          prefixIcon: Icon(Icons.numbers),
                        ),
                        validator: (value) {
                          return MyValidators.cvvValidator(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0), // Add vertical spacing if needed
                ElevatedButton(
                  onPressed: () async {
                    await _pay();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    backgroundColor: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    "Pay",
                    style: TextStyle(
                      color: AppColors.darkColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
