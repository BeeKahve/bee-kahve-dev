import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/consts/validator.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/root.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateAddressScreen extends StatefulWidget {
  final User? user;
  const UpdateAddressScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  late final TextEditingController _addressController;
  User? user;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _addressController = TextEditingController();
    user = widget.user;
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
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      final String address = _addressController.text;
      final Map<String, dynamic> requestBody = {
        'customer_id': widget.user!.customerId, 
        'address': address,
      };
    try {
      final response = await http.post(
        Uri.parse('http://51.20.117.162:8000/update_address'),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonResponse = json.decode(response.body);

        // Check if the registration was successful
        if (jsonResponse['status'] == true) {
          // Registration successful
          // Handle success as needed
          print('Updating address is successful');
          print('Message: ${jsonResponse['message']}');
          widget.user!.address = requestBody['address'];
          Navigator.pop(context);
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootScreen( currentScreen: 2,user: widget.user),
          ),
        );
        } else {
          // Registration failed
          // Handle failure, e.g., display an error message
          print('Updating address is failed. Message: ${jsonResponse['message']}');
        }
      } else {
        // Registration failed
        // Handle failure, e.g., display an error message
        print('Updating address is failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other exceptions, such as network issues
      print('Error during updating address: $e');
    }
  }
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
