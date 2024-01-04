// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/line_items_model.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class RatePage extends StatefulWidget {
  final User? user;
  final Coffee product;
  const RatePage({Key? key, required this.user, required this.product})
      : super(key: key);

  @override
  State<RatePage> createState() => _RatePage();
}

class _RatePage extends State<RatePage> {
  late Coffee product;
  late double rate = 0;
  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  Future<void> _rate() async {
    FocusScope.of(context).unfocus();
    try {
      final Map<String, dynamic> requestBody = {
        'product_id': product.id,
        'rate': rate,
      };
      final response = await http.post(
        Uri.parse('http://51.20.117.162:8000/rate'),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          print("Order placed successfully");
          print("Message: ${jsonResponse['message']}");
          Navigator.pop(context);
        } else {
          print("Order placement failed. Message: ${jsonResponse['message']}");
        }
      } else {
        print('Order placement failed: Status code: ${response.statusCode}');
        // Handle the error if the server did not return a 200 OK response
      }
    } catch (e) {
      print('Error during order placement: $e');
      // Handle other exceptions, such as network issues
    }
  }

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
            CachedNetworkImage(
              imageUrl: product.photoPath,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 4.0,
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(
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
                setState(() {
                  rate = rating;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _rate();
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
