import 'package:flutter/material.dart';
import '../../consts/app_color.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText
  });

  final String imagePath, title, subtitle, buttonText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            imagePath,
            width: double.infinity,
            height: size.height * 0.3,
          ),
          const Text(
            "Whoops",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppColors.textColor
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppColors.textColor
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: AppColors.textColor
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: AppColors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {},
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: AppColors.darkColor
                ),

              )
          ),
        ],
      ),
    );
  }
}
