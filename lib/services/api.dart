import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sw_teste/constants/strings.dart';
import 'package:sw_teste/enums/application_type.dart';
import 'package:sw_teste/enums/grant_type.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/auth_request.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/models/user.dart';
import 'package:sw_teste/services/auth.dart';
import 'package:sw_teste/services/setup_locator.dart';
import 'package:sw_teste/utils/functions/handle_http_exceptions.dart';

const baseUrl = String.fromEnvironment('BASE_URL');

class ApiService {
  Future<Either<AppError, bool>> cancelToken(AuthRequest authRequest) async {
    final Either<AppError, http.Response> response = await handleHttpExceptions(
      () async => await http.post(
        Uri.parse('$baseUrl/connect/revocation'),
        headers: {"Content-Type": ContentTypes.urlencoded.type},
        body: authRequest.toJsonCancelToken(),
      ),
    );

    return response.fold((AppError error) {
      return Either.left(error);
    }, (http.Response response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(true);
      }

      return Either.left(AppError.fromJson(json.decode(response.body)));
    });
  }

  Future<Either<AppError, Auth>> refreshToken() async {
    AuthService authService = getIt<AuthService>();
    final AuthRequest authRequest = AuthRequest(
      grantType: GrantType.refreshToken.type,
      clientId: AppStrings.clientId,
      refreshToken: authService.appAuth.value.refreshToken,
    );
    final Either<AppError, http.Response> response = await handleHttpExceptions(
      () async => await http.post(
        Uri.parse('$baseUrl/connect/token'),
        headers: {"Content-Type": ContentTypes.urlencoded.type},
        body: authRequest.toJsonRefresh(),
      ),
    );

    return response.fold((AppError error) {
      return Either.left(error);
    }, (http.Response response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        await authService.saveTokens(Auth.fromJson(json.decode(response.body)));
        return Either.right(Auth.fromJson(json.decode(response.body)));
      }

      return Either.left(AppError.fromJson(json.decode(response.body)));
    });
  }

  Future<Either<AppError, User>> fetchUser() async {
    final Either<AppError, http.Response> response = await handleHttpExceptions(
      () async => await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: {"Authorization": "Bearer ${getIt<AuthService>().appAuth.value.accessToken}"},
      ),
    );

    return response.fold((AppError error) {
      return Either.left(error);
    }, (http.Response response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(User.fromJson(json.decode(response.body)));
      }
      if (response.statusCode == 401) {
        await refreshToken();
        return await fetchUser();
      }
      return Either.left(AppError.fromJson(json.decode(response.body)));
    });
  }

  Future<Either<AppError, Auth>> login(AuthRequest auth) async {
    final Either<AppError, http.Response> response = await handleHttpExceptions(
      () async => await http.post(
        Uri.parse('$baseUrl/connect/token'),
        headers: {"Content-Type": ContentTypes.urlencoded.type},
        body: auth.toJson(),
      ),
    );

    return response.fold((AppError error) {
      return Either.left(error);
    }, (http.Response response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(Auth.fromJson(json.decode(response.body)));
      }

      return Either.left(AppError.fromJson(json.decode(response.body)));
    });
  }

  Future<Either<AppError, List<Order>>> fetchOrders({bool isFinished = true}) async {
    final Either<AppError, http.Response> response = await handleHttpExceptions(
      () async => await http.get(
        Uri.parse('$baseUrl/orders?includeFinished=$isFinished'),
        headers: {
          "Content-Type": ContentTypes.json.type,
          "Authorization": "Bearer ${getIt<AuthService>().appAuth.value.accessToken}",
        },
      ),
    );

    return response.fold((AppError error) {
      return Either.left(error);
    }, (http.Response response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(orderFromJson(response.body));
      }
      if (response.statusCode == 401) {
        await refreshToken();
        return await fetchOrders();
      }
      return Either.left(AppError.fromJson(json.decode(response.body)));
    });
  }

  Future<Either<AppError, Order>> newOrder(Order order) async {
    final Either<AppError, http.Response> response = await handleHttpExceptions(
      () async => await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: {
          "Content-Type": ContentTypes.json.type,
          "Authorization": "Bearer ${getIt<AuthService>().appAuth.value.accessToken}",
        },
        body: json.encode(order.toJson()),
      ),
    );

    return response.fold((AppError error) {
      return Either.left(error);
    }, (http.Response response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(Order.fromJson(json.decode(response.body)));
      }
      if (response.statusCode == 401) {
        await refreshToken();
        return await newOrder(order);
      }
      return Either.left(AppError.fromJson(json.decode(response.body)));
    });
  }

  Future<Either<AppError, Order>> finishOrder(Order order) async {
    final Either<AppError, http.Response> response = await handleHttpExceptions(
      () async => await http.put(
        Uri.parse('$baseUrl/orders/${order.id}/finish'),
        headers: {
          "Authorization": "Bearer ${getIt<AuthService>().appAuth.value.accessToken}",
        },
        body: order.toJson(),
      ),
    );

    return response.fold((AppError error) {
      return Either.left(error);
    }, (http.Response response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Either.right(Order.fromJson(json.decode(response.body)));
      }
      if (response.statusCode == 401) {
        await refreshToken();
        return await finishOrder(order);
      }
      return Either.left(AppError.fromJson(json.decode(response.body)));
    });
  }
}
