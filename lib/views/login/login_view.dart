import 'package:flutter/material.dart';
import 'package:sw_teste/constants/colors.dart';
import 'package:sw_teste/views/login/widgets/form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.startPurple, AppColors.endPurple],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Image.asset('assets/logo.png'),
                LoginFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
