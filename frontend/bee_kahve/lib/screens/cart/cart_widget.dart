import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/line_items_model.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  final User? user;
  const CartWidget({Key? key, required this.product, required this.user})
      : super(key: key);
  final Coffee product;
  @override
  State<CartWidget> createState() => _CartWidget();
}

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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Milk Type: ${product.milkChoice ?? 'not selected'}"),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Extra Shot: ${product.extraShotChoice ?? false}"),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Decaf: ${product.caffeineChoice ?? false}"),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Size: ${product.sizeChoice ?? 'not selected'}"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${(product.price * cartProvider.cartItems[product]!.toInt()).toStringAsFixed(2)}\₺",
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
