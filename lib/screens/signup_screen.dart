import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixtasy/resources/auth_methods.dart';
import 'package:pixtasy/screens/login_screen.dart';
import 'package:pixtasy/utils/colors.dart';
import 'package:pixtasy/utils/utils.dart';
import 'package:pixtasy/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      username: _usernameController.text,
      file: _image!,
    );

    setState(() {
      isLoading = false;
    });

    if (res != 'success') {
      return showSnackBar(res, context);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (builder) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset : false,
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
              Image.asset(
                "assets/pixtasy.png",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              // circular widget to accept and show selected file
              // we can create a stack so we can create a button and circular avatar on top of each other
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/05/86/91/55/240_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg',
                          ),
                        ),

                  //adding an icon button
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              //text field input for user name
              TextFieldInput(
                hintText: "Enter your username",
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              // text field input for email
              TextFieldInput(
                hintText: "Enter your email",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              // text field input for password
              TextFieldInput(
                hintText: "Enter your password",
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              //text field input for bio
              TextFieldInput(
                hintText: "Enter your bio",
                textEditingController: _bioController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              // login button
              InkWell(
                onTap: signUpUser,
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
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("Sign up"),
                ),
              ),
              const SizedBox(height: 17),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
