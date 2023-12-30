import 'package:bee_kahve/consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePage();
}

class _RatePage extends State<RatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Rate",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: AppColors.textColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/cappuccino.jpg",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              "Cappuccino",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 20),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.yellow,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0,
                ),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: AppColors.darkColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
