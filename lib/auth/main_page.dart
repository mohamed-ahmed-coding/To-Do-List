import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/auth/main_page_auth.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/screens/home_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: AppColors.primaryColor,
            backgroundColor: AppColors.whiteColor,
          ));
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return MainPageAuth();
        }
      }),
    );
  }
}