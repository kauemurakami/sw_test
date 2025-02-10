import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sw_teste/enums/application_type.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/auth_request.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';

const baseUrl = String.fromEnvironment('BASE_URL');

class ApiService {
  Future<Either<AppError, Auth>> login(AuthRequest auth) async {
    //POST
    try {
      print(ContentTypes.urlencoded.type);
      final response = await http.post(
        Uri.parse('$baseUrl/connect/token'),
        headers: {
          "Content-Type": ContentTypes.urlencoded.type,
        },
        body: auth.toJson(),
      );
      print(response.body);
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

  fetchOrders() async {
    //GET
  }
  addOrder() async {
    //POST
  }
  finishOrder() async {
    //PUT
  }
}
