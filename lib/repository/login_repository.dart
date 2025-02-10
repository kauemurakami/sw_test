import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/services/api.dart';
import 'package:sw_teste/services/setup_locator.dart';

class LoginRepository {
  final ApiService api = getIt<ApiService>();
  fetchUser() async {
    //GET
  }

  Future<Either<AppError, Auth>> login(Auth auth) async => api.login(auth);
}
