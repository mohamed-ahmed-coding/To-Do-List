import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/data/auth_data.dart';
import 'package:to_do_list/widgets/login_image.dart';
import 'package:to_do_list/widgets/primary_button.dart';
import 'package:to_do_list/widgets/text_field_widget.dart';


class SignupScreen extends StatefulWidget {
  final VoidCallback? show;
  const SignupScreen({super.key,this.show});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              LoginImage(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an Account :',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFieldWidget(controller: email, focusNode: _focusNode1, hintText: 'Email', icon: Icons.email, obscureText: false),
                      SizedBox(height: 15),
                      TextFieldWidget(controller: password, focusNode: _focusNode2, hintText: 'Password', icon: Icons.lock, obscureText: true),
                      SizedBox(height: 15),
                      TextFieldWidget(controller: confirmPassword, focusNode: _focusNode3, hintText: 'Confirm Password', icon: Icons.lock, obscureText: true),
                      SizedBox(height: 20),
                      PrimaryButton(text: 'Sign Up', size: Size(double.infinity, 50), onPressed: () async{
                        await AuthRemote().signUp(email.text, password.text, confirmPassword.text);
                      }),
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}