import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/screens/cart/payment.dart';
import 'package:bee_kahve/screens/products/product_details.dart';
import 'package:flutter/material.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';

class CartBottomSheetWidget extends StatelessWidget {
  CartBottomSheetWidget({super.key});
  CartProvider cartProvider = CartProvider();
  String calculateTotal() {
    int total = 0;
    for (int quantity in cartProvider.cartItems.values.toList()) {
      total += quantity;
    }
    return total.toString();
  }

  String calculatePrice() {
    double total = 0;
    for (Coffee product in cartProvider.cartItems.keys.toList()) {
      total += product.price * cartProvider.cartItems[product]!;
    }
    return total.toStringAsFixed(2);
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
                      "${calculatePrice()}\₺",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentPage()));
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
