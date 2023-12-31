import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/screens/cart/payment.dart';
import 'package:flutter/material.dart';

class CartBottomSheetWidget extends StatelessWidget {
  const CartBottomSheetWidget({super.key});

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
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total (6 coffee)",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.textColor,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      "16.00\$",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellow,
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
