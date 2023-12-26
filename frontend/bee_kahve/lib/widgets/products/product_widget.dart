import 'dart:developer';

import 'package:bee_kahve/consts/app_color.dart';
// import 'package:bee_kahve/consts/app_constants.dart';
import 'package:bee_kahve/screens/products/product_details.dart';
import 'package:flutter/material.dart';
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetailsScreen()));
          //To do navigate product detail screen
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset('assets/images/cappuccino.jpg', height: 140, width: double.infinity,),
              /*child: FancyShimmerImage(
                imageUrl: AppConstants.imageUrl,
                width: double.infinity,
                height: size.height*0.20,
              ),*/
            ),
            const SizedBox(height: 5,),
            const Row(
              children: [
                Text("Coffee Latte", style: TextStyle(color: AppColors.textColor),),

              ],
            )
          ],
        ),
      );
  }
}
