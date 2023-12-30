import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});
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
                imageUrl: 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
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
                            child: Text("Cappuccino" * 10)
                        ),
                        Column(
                          children: [
                            IconButton(onPressed: (){}, icon: const Icon(Icons.clear)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("16.00\$"),
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
