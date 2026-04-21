import 'package:flutter/material.dart';
import 'package:to_do_list/screens/login_screen.dart';
import 'package:to_do_list/screens/signup_screen.dart';

class MainPageAuth extends StatefulWidget {
  const MainPageAuth({super.key});

  @override
  State<MainPageAuth> createState() => _MainPageAuthState();
}

class _MainPageAuthState extends State<MainPageAuth> {
  bool showLogin = true;
  void toggleScreen() {
    setState(() {
      showLogin = !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    return showLogin ? LoginScreen(show: toggleScreen) : SignupScreen(show: toggleScreen);
  }
}