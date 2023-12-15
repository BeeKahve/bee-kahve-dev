import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/consts/validator.dart';
import 'package:flutter/material.dart';

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
  Future<void> _signup()async{
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25,),
                 Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.keyboard_backspace, size: 32,),
                      ),
                    ],
                  ),
                ),
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
                          obscureText: obscureText,
                          controller: _repeatPasswordController,
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
