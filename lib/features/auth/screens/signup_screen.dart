import 'package:book_verse/features/auth/screens/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/custom_signUp_button.dart';
import '../../../common/custom_textField.dart';
import '../../../utils/move_screen.dart';
import '../controllers/auth_controller.dart';
import '../models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUp(BuildContext context) {
    UserModel model = UserModel(
        booksRead: '0',
        verseCoins: '0',
        name: _nameController.text,
        uid: '',
        email: _emailController.text,
        password: _passwordController.text);

    AuthController controller = AuthController();

    controller.signUp(context, model);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.2,
                width: double.infinity,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('resources/images/bg_banner.png'),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 68.0, top: 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Sign up to make a \nbrand new Account",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          "Sign up , and make a brand new Account",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Name',
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                isObscure: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  signUp(context);
                },
                child: const CustomSignUpButton(),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Already have an account!!",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      moveScreen(context, const SignInScreen());
                    },
                    child: Text(
                      "\tSign in",
                      style: GoogleFonts.roboto(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
