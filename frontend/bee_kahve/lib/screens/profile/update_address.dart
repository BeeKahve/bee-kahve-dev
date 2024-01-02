import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/consts/validator.dart';
import 'package:flutter/material.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({super.key});

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  late final TextEditingController _addressController;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _addressController.dispose();
      super.dispose();
    }
  }

  Future<void> _update_address() async {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/bee-logo.png',
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Update Address",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor),
                ),
                const SizedBox(
                  height: 60,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _addressController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(
                              hintText: "Address",
                              prefixIcon: Icon(Icons.home_filled)),
                          validator: (value) {
                            return MyValidators.addressValidator(value);
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              backgroundColor: AppColors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () async {
                              await _update_address();
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: AppColors.darkColor),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
