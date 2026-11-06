import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/colors.dart';
import 'package:flutter_application_1/Data/auth.dart';
import 'package:flutter_application_1/Presentation/Screens/home_screen.dart';
import 'package:flutter_application_1/Presentation/Screens/signUp_screen.dart';
import 'package:flutter_application_1/Presentation/Widgets/custom_textfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextfields(
                  hint_text: 'Email',
                  controller: emailController,
                ),
                CustomTextfields(
                  hint_text: 'Password',
                  controller: passwordController,
                ),
              ],
            ),
          ),

          //Login Button
          GestureDetector(
            onTap: () async {
              try {
                if (formKey.currentState!.validate()) {
                  await Auth().login(
                    emailController.text,
                    passwordController.text,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  debugPrint('Login Success');
                }
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          //Create Account
          TextButton(
            child: Text('Create Account', textAlign: TextAlign.center),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
