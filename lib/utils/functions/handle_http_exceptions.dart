import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';

Future<Either<AppError, http.Response>> handleHttpExceptions(Future<http.Response> Function() request) async {
  try {
    final response = await request();

    return Either.right(response);
  } on SocketException catch (_) {
    return Either.left(AppError(
      error: 'SocketException',
      errorDescription: 'Problema de conexão com a internet.',
    ));
  } on HttpException catch (_) {
    return Either.left(AppError(
      error: 'HttpException',
      errorDescription: 'Erro ao tentar acessar o servidor.',
    ));
  } on FormatException catch (_) {
    return Either.left(AppError(
      error: 'FormatException',
      errorDescription: 'Erro ao processar a resposta.',
    ));
  } on TimeoutException catch (_) {
    return Either.left(AppError(
      error: 'TimeoutException',
      errorDescription: 'Tempo de requisição excedido.',
    ));
  } catch (e) {
    return Either.left(AppError(
        error: 'Erro inesperado.',
        errorDescription: 'Ocorreu um erro inesperado, tente novamente, ou entre em contato com o suporte'));
  }
}
