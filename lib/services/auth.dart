import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sw_teste/constants/keys.dart';

class AuthService with ChangeNotifier {
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await storage.write(key: AppKeys.aToken, value: accessToken);
    await storage.write(key: AppKeys.rToken, value: refreshToken);
  }
}
