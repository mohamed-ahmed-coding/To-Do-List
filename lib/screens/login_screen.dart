import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/data/auth_data.dart';
import 'package:to_do_list/widgets/login_image.dart';
import 'package:to_do_list/widgets/primary_button.dart';
import 'package:to_do_list/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? show;
  const LoginScreen({super.key,this.show});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      await AuthRemote().login(email.text, password.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                        'Welcome Back!',
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
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.show,
                            child: Text(
                              ' Sign Up',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      PrimaryButton(
                        text: _isLoading ? "Logging in..." : "Login",
                        size: Size(double.infinity, 50),
                        onPressed: _handleLogin,
                      ),
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
