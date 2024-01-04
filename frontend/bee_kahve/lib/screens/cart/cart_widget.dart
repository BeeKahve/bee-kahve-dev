import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/line_items_model.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  final User? user;
  final bool isReward;
  const CartWidget(
      {Key? key,
      required this.product,
      required this.user,
      this.isReward = false})
      : super(key: key);
  final Coffee product;
  @override
  State<CartWidget> createState() => _CartWidget();
}

const Map<String, String> milkTypes = {
  "whole_milk": "Whole Milk",
  "reduced_fat_milk": "Reduced Fat Milk",
  "lactose_free_milk": "Lactose Free Milk",
  "oat_milk": "Oat Milk",
  "almond_milk": "Almond Milk",
};

const Map<String, String> sizes = {
  "small": "Small",
  "medium": "Medium",
  "large": "Large",
};

class _CartWidget extends State<CartWidget> {
  late Coffee product;
  CartProvider cartProvider = CartProvider();
  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FancyShimmerImage(
                  imageUrl: product.photoPath,
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (product.milkChoice != null)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${milkTypes[product.milkChoice]}"),
                            ),
                          if (product.extraShotChoice ?? false)
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Extra Shot"),
                            ),
                          if (product.caffeineChoice ?? false)
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Decaf"),
                            ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                sizes[product.sizeChoice] ?? 'not selected'),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !widget.isReward,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${(product.price * (cartProvider.cartItems[product]?.toInt() ?? 0)).toStringAsFixed(2)}\₺",
                          ),
                          IconButton(
                              onPressed: () {
                                cartProvider.removeFromCart(product);
                              },
                              icon: const Icon(Icons.remove)),
                          Text(cartProvider.cartItems[product].toString()),
                          IconButton(
                              onPressed: () {
                                cartProvider.addToCart(product);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
