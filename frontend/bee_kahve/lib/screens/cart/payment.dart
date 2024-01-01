import 'package:bee_kahve/consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Payment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: AppColors.textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: "#### #### #### ####",
                  )
                ],
                decoration: const InputDecoration(
                  hintText: "Card Number",
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              const SizedBox(height: 16.0), // Add vertical spacing if needed
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: "##/##",
                            filter: {
                              '#': RegExp(r'[0-9]'),
                            },
                            type: MaskAutoCompletionType.eager,
                          ),
                        ],
                        decoration: InputDecoration(
                          hintText: "Expiration Date",
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5) {
                            return "write date";
                          }
                          final components = value.split("/");
                          if (components.length == 2) {
                            final month = int.tryParse(components[0]);
                            final year = int.tryParse(components[1]);
                            if (month == null || year == null) {
                              return "wrong date";
                            }
                            if (month > 13 || year < 24 || year > 39) {
                              return "wrong date";
                            }
                          }
                        }),
                  ),
                  SizedBox(width: 16.0), // Add horizontal spacing if needed
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      decoration: InputDecoration(
                        hintText: "CVV",
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0), // Add vertical spacing if needed
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  backgroundColor: AppColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  "Pay",
                  style: TextStyle(
                    color: AppColors.darkColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
