import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:pixtasy/utils/colors.dart';
import 'package:pixtasy/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              // svg image
              // SvgPicture.asset(
              //   'assets/pixtasy_icon.svg',
              Image.asset(
                "assets/pixtasy.png",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              // text field input for email
              TextFieldInput(
                hintText: "Username",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 34),
              // text field input for password
              TextFieldInput(
                hintText: "Enter your password",
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height: 34),
              // login button
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: Colors.blue,
                  ),
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(height: 17),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              // Transition to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
