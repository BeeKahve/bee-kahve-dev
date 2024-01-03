import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:bee_kahve/screens/products/product_details.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:bee_kahve/screens/cart/cart_provider.dart';

class CartWidget extends StatelessWidget {
  CartWidget({Key? key, required this.product}) : super(key: key);
  final Coffee product;
  CartProvider cartProvider = CartProvider();
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
                              child: Text(product.name, style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold, fontSize: 18),),
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
                            child: Text("Milk Type: ${product.milkType ?? 'not selected'}"),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Extra Shot: ${product.extraShot ?? false}"),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Decaf: ${product.decaf ?? false}"),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Size: ${product.size ?? 'not selected'}"),
                          ),
                        ],
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (product.size == "small")
                          Text("${product.price}\₺"),
                        if (product.size == "medium")
                          Text("${(product.price * 1.3).toStringAsFixed(2)}\₺"),
                        if (product.size == "large")
                          Text("${(product.price * 1.7).toStringAsFixed(2)}\₺"),
                        Icon(Icons.remove),
                        Text(cartProvider.cartItems[product]),
                        Icon(Icons.add),
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
