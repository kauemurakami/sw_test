import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_teste/services/setup_locator.dart';
import 'package:sw_teste/view_model/login.dart';
import 'package:sw_teste/view_model/orders.dart';
import 'package:sw_teste/views/login/login_view.dart';
import 'package:sw_teste/views/orders_view.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sw test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => LoginController(),
        child: LoginPage(),
      ),
    );
  }
}
