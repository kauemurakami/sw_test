import 'package:get_it/get_it.dart';
import 'package:sw_teste/services/api.dart';
import 'package:sw_teste/services/auth.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
}
