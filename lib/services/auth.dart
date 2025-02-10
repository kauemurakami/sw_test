import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sw_teste/constants/keys.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/user.dart';

class AuthService with ChangeNotifier {
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  ValueNotifier<Auth> appAuth = ValueNotifier(Auth());
  ValueNotifier<User> user = ValueNotifier(User());

  Future<void> saveTokens(Auth auth) async {
    appAuth.value = auth;
    await storage.write(key: AppKeys.aToken, value: auth.accessToken);
    await storage.write(key: AppKeys.rToken, value: auth.refreshToken);
  }

  Future<void> clearTokens() async => await storage.deleteAll();
}
