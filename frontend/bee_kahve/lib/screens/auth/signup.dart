import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/consts/validator.dart';
import 'package:bee_kahve/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswordController;
  late final TextEditingController _addressController;
  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureTextConfirm = true;

  @override
  void initState(){
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    if(mounted){
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      _addressController.dispose();
      super.dispose();
    }
  }
 Future<void> _signup() async {
  final isValid = _formkey.currentState!.validate();
  FocusScope.of(context).unfocus();

  if (isValid) {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String address = _addressController.text;

    // Create the request body
    final Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
      'name': name,
      'address': address,
    };
    print(requestBody);
    try {
      final response = await http.post(
        Uri.parse('http://51.20.117.162:8000/register'),
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
          print('Registration successful');
          print('Message: ${jsonResponse['message']}');
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const SignInScreen()));
        } else {
          // Registration failed
          // Handle failure, e.g., display an error message
          print('Registration failed. Message: ${jsonResponse['message']}');
        }
      } else {
        // Registration failed
        // Handle failure, e.g., display an error message
        print('Registration failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other exceptions, such as network issues
      print('Error during registration: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25,),
                Image.asset('assets/images/bee-logo.png', height: 100,),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textColor),
                ),
                const SizedBox(height: 20,),
                Form(key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              hintText: "Name",
                              prefixIcon: Icon(Icons.message)),
                          validator: (value){
                            return MyValidators.nameValidator(value);
                          },
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "Email address",
                            prefixIcon: Icon(Icons.email)),
                        validator: (value){
                          return MyValidators.emailValidator(value);
                        },
                      ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          obscureText: obscureText,
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock)),
                          validator: (value){
                            return MyValidators.passwordValidator(value);
                          },
                        ),
                        const SizedBox(height: 20,),

                        TextFormField(
                          obscureText: obscureTextConfirm,
                          controller: _repeatPasswordController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureTextConfirm = !obscureTextConfirm;
                                  });
                                },
                                icon: Icon(
                                  obscureTextConfirm
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              hintText: "Confirm Password",
                              prefixIcon: const Icon(Icons.lock)),
                          validator: (value){
                            return MyValidators.repeatPasswordValidator(
                              value: value,
                              password: _passwordController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 20,),

                        TextFormField(
                          controller: _addressController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(
                              hintText: "Address",
                              prefixIcon: Icon(Icons.home_filled)),
                          validator: (value){
                            return MyValidators.addressValidator(value);
                          },
                        ),
                        const SizedBox(height: 32,),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              backgroundColor: AppColors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () async {
                              await _signup();
                            },
                            child: const Text("Create Account", style: TextStyle(color: AppColors.darkColor),),
                          ),
                        ),

                      ],)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
