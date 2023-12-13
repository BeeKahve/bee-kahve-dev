import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/consts/validator.dart';
import 'package:bee_kahve/screens/auth/signup.dart';
import 'package:flutter/material.dart';

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
  void initState(){
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    if(mounted){
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
  }
  Future<void> _signin()async{
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
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100,),
                Image.asset('assets/images/bee-logo.png', height: 100,),
                const SizedBox(height: 20,),
                const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textColor),
                ),
                const SizedBox(height: 40,),
                Form(key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [TextFormField(
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
                        const SizedBox(height: 40,),
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
                              validator: (value){
                                return MyValidators.passwordValidator(value);
                              },
                        ),
                        const SizedBox(height: 40,),
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
                          child: const Text("Sign in", style: TextStyle(color: AppColors.darkColor),),

                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                            }, child: const Text("Sign Up", style: TextStyle(color: AppColors.yellow),),
                            )
                          ],
                        )
                      ],)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
