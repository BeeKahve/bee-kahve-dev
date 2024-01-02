import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/root.dart';
import 'package:bee_kahve/screens/home.dart';
import 'package:bee_kahve/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:bee_kahve/consts/validator.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  late final TextEditingController _cardNumberController;
  late final TextEditingController _dateController;
  late final TextEditingController _cvvController;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _cardNumberController = TextEditingController();
    _dateController = TextEditingController();
    _cvvController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _cardNumberController.dispose();
      _dateController.dispose();
      _cvvController.dispose();
      super.dispose();
    }
  }

  Future<void> _pay() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const RootScreen(
                    currentScreen: 2,
                  )));
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
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
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
                  validator: (value) {
                    return MyValidators.cardNumberValidator(value);
                  },
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
                          ),
                        ],
                        decoration: const InputDecoration(
                          hintText: "Expiration Date",
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          return MyValidators.dateValidator(value);
                        },
                      ),
                    ),
                    SizedBox(width: 16.0), // Add horizontal spacing if needed
                    Expanded(
                      child: TextFormField(
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
                        validator: (value) {
                          return MyValidators.cvvValidator(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0), // Add vertical spacing if needed
                ElevatedButton(
                  onPressed: () async {
                    // Navigator.pop(context);
                    await _pay();
                  },
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
      ),
    );
  }
}
