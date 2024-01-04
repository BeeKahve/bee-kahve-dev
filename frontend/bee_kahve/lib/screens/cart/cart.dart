import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/screens/cart/bottom_checkout.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:bee_kahve/screens/cart/cart_widget.dart';
import 'package:bee_kahve/widgets/cart/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final User? user;
  const CartScreen({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Visibility(
            visible: Provider.of<CartProvider>(context).cartItems.isNotEmpty,
            child: IconButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart();
              },
              icon: const Icon(Icons.delete_forever_rounded),
            ),
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItems.isEmpty) {
            return EmptyCartWidget(
              user: user,
              imagePath: 'assets/images/basket.png',
              title: "Your cart is empty",
              subtitle: "Looks like your cart is empty. Add something!",
              buttonText: "Shop Now",
            );
          } else {
            return ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                return CartWidget(
                    product: cartProvider.cartItems.keys.toList()[index],
                    user: user);
              },
            );
          }
        },
      ),
      bottomSheet: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItems.isNotEmpty) {
            return CartBottomSheetWidget(user: user);
          } else {
            return SizedBox
                .shrink(); // Return an empty widget if the cart is empty
          }
        },
      ),
    );
  }
}
