import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/consts/validator.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/root.dart';
import 'package:bee_kahve/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
  }

  Future<void> _signin() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      // final String plainPassword = _passwordController.text;
      // // Hash the password using SHA-512
      // final String hashedPassword = sha512.convert(utf8.encode(plainPassword)).toString();

      // Create the request body
      final Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };

      try {
        final response = await http.post(
          Uri.parse('http://51.20.117.162:8000/login'),
          body: json.encode(requestBody),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          // Parse the JSON response
          final jsonResponse = json.decode(response.body);

          // Check if login was successful
          if (jsonResponse['customer_id'] != null) {
            // Login successful
            // Create a User instance
            User user = User.fromJson(jsonResponse);

            // Handle success as needed
            print('Login successful');
            print('Customer ID: ${user.customerId}');
            print('Name: ${user.name}');
            print('Email: ${user.email}');
            print('Address: ${user.address}');
            print('Loyalty Count: ${user.loyaltyCount}');

            setState(() {
              user = user;
            });
            // Example: Navigate to the profile screen after successful login
            // ignore: use_build_context_synchronously
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => RootScreen(user: user, currentScreen: 0),
              ),
            );
          } else {
            // Show error message
            final errorMessage = jsonResponse['message'] ??
                'Login failed. Please check your credentials.';
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMessage),
              duration: const Duration(seconds: 2),
            ));
          }
        } else {
          // Login failed
          // Handle failure, e.g., display an error message
          print('Login failed. Status code: ${response.statusCode}');
        }
      } catch (e) {
        // Handle other exceptions, such as network issues
        // Show error message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error during login: $e'),
          duration: const Duration(seconds: 2),
        ));
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
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/images/bee-logo.png',
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: "Email address",
                              prefixIcon: Icon(Icons.email)),
                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          obscureText: obscureText,
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
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
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                        ),
                        const SizedBox(
                          height: 40,
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
                              await _signin();
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(color: AppColors.darkColor),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: AppColors.yellow),
                              ),
                            )
                          ],
                        )
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
