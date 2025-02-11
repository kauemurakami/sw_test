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

  Future<void> init() async {
    await getTokens();
  }

  Future<void> getTokens() async {
    print('get tokens');
    appAuth.value.accessToken = await storage.read(key: AppKeys.aToken);
    appAuth.value.refreshToken = await storage.read(key: AppKeys.rToken);
    notifyListeners();
  }

  Future<void> saveTokens(Auth auth) async {
    appAuth.value = auth;
    await storage.write(key: AppKeys.aToken, value: auth.accessToken);
    await storage.write(key: AppKeys.rToken, value: auth.refreshToken);
  }

  Future<void> clearTokens() async => await storage.deleteAll();
}
