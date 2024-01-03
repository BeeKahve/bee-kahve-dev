import 'package:bee_kahve/screens/cart/cart_provider.dart';
import 'package:bee_kahve/screens/products/product_details.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key, required this.product}) : super(key: key);
  final Coffee product;
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
                            child: Text(product.name),
                        ),
                        Column(
                          children: [
                            IconButton(onPressed: (){
                              CartProvider().removeFromCart(product.id);
                            }, icon: const Icon(Icons.clear)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Milk Type: ${product.milkType ?? 'Not selected'}"),
                    Text("Extra Shot: ${product.extraShot ?? false}"),
                    Text("Decaf: ${product.decaf ?? false}"),
                    Text("Size: ${product.size ?? 'Not selected'}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${product.price}\₺"),
                        OutlinedButton.icon(
                            onPressed: (){},
                            icon: const Icon(Icons.arrow_drop_down) ,
                            label: const Text("Qty: 6"),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                              )
                            ),

                        )
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
