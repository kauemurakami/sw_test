import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sw_teste/enums/application_type.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/auth_request.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/models/user.dart';
import 'package:sw_teste/services/auth.dart';
import 'package:sw_teste/services/setup_locator.dart';

const baseUrl = String.fromEnvironment('BASE_URL');

class ApiService {
  Future<Either<AppError, User>> fetchUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: {
          "Authorization": "Bearer ${getIt<AuthService>().appAuth.value.accessToken}",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(User.fromJson(json.decode(response.body)));
      }
      //  else if (response.statusCode == 403 || response.statusCode == 401) {
      //   print('token expirado');
      // }
      else {
        return Either.left(AppError.fromJson(json.decode(response.body)));
      }
    } catch (e) {
      return Either.left(AppError(
          error: 'Erro inesperado.',
          errorDescription: 'Ocorreu um erro inesperado, tente novamente, ou entre em contato com o suporte'));
    }
  }

  Future<Either<AppError, Auth>> login(AuthRequest auth) async {
    //POST
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/connect/token'),
        headers: {
          "Content-Type": ContentTypes.urlencoded.type,
        },
        body: auth.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(Auth.fromJson(json.decode(response.body)));
      } else {
        return Either.left(AppError.fromJson(json.decode(response.body)));
      }
    } catch (e) {
      return Either.left(AppError(
          error: 'Erro inesperado.',
          errorDescription: 'Ocorreu um erro inesperado, tente novamente, ou entre em contato com o suporte'));
    }
  }

  Future<Either<AppError, Auth>> refreshToken() async {
    return Either.left(AppError(error: 's', errorDescription: ''));
  }

  Future<Either<AppError, List<Order>>> fetchOrders({bool isFinished = false}) async {
    //GET
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print(Uri.parse('$baseUrl/orders?includeFinished=$isFinished'));
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders?includeFinished=$isFinished'),
        headers: {
          "Authorization": "Bearer ${getIt<AuthService>().appAuth.value.accessToken}",
        },
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(orderFromJson(response.body));
      }
      if (response.statusCode == 403 || response.statusCode == 401) {
        print('token expirado');
      }
      return Either.left(AppError.fromJson(json.decode(response.body)));
    } catch (e) {
      return Either.left(AppError(
          error: 'Erro inesperado.',
          errorDescription: 'Ocorreu um erro inesperado, tente novamente, ou entre em contato com o suporte'));
    }
  }

  addOrder() async {
    //POST
  }
  finishOrder() async {
    //PUT
  }
}
