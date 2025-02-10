import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sw_teste/enums/application_type.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';

// const baseUrl = 'https://dev-techtest.swfast.com.br';
const baseUrl = String.fromEnvironment('BASE_URL');

class ApiService {
  Future<Either<AppError, Auth>> login(Auth auth) async {
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
