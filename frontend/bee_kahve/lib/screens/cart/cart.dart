import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/screens/cart/bottom_checkout.dart';
import 'package:bee_kahve/widgets/cart/empty_cart.dart';
import 'package:flutter/material.dart';

import 'cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isEmpty? const Scaffold(
      body: EmptyCartWidget(
        imagePath: 'assets/images/basket.png',
        title: "Your cart is empty",
        subtitle: "Looks like your cart is empty add something",
        buttonText: "Shop Now",
      )
    ) :
      Scaffold(
        bottomSheet: const CartBottomSheetWidget(),
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          ),
          title: const Text(
              "Cart",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.delete_forever_rounded)
            )],
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index){
            return const CartWidget();
        }),
      );
  }
}
