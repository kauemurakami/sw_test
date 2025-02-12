import 'package:flutter/material.dart';
import 'package:sw_teste/constants/strings.dart';
import 'package:sw_teste/enums/grant_type.dart';
import 'package:sw_teste/models/auth_request.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/repository/orders_repository.dart';
import 'package:sw_teste/services/auth.dart';
import 'package:sw_teste/services/setup_locator.dart';

class OrdersController with ChangeNotifier {
  final OrdersRepository repository = OrdersRepository();
  ValueNotifier<List<Order>> orders = ValueNotifier(<Order>[]);
  ValueNotifier<bool> isFinished = ValueNotifier(true);
  ValueNotifier<bool> load = ValueNotifier(true);

  Future<void> filterOrders(bool value) async {
    if (value != isFinished.value) {
      isFinished.value = value;
      notifyListeners();
      await fetchOrders();
    }
  }

  Future<Either<AppError, Order>> finishOrder(Order order) async {
    final Either<AppError, Order> result = await repository.finishOrder(order);
    result.fold((error) {
      //TODO: qualquer outro tratamento aqui
    }, (Order order) {
      final int orderIndex = orders.value.indexWhere((Order o) => o.id == order.id);
      orders.value[orderIndex] = order;
      orders.notifyListeners();
    });
    return result;
  }

  Future<Either<AppError, List<Order>>> fetchOrders() async {
    Either<AppError, List<Order>> result = await repository.fetchOrders(isFinished: isFinished.value);
    result.fold((error) {
      //TODO: qualquer outro tratamento aqui
    }, (List<Order> orders) {
      this.orders.value = orders;
      notifyListeners();
    });
    load.value = false;
    notifyListeners();
    return result;
  }

  Future<Either<AppError, bool>> logout() async {
    final AuthService authService = getIt<AuthService>();
    final AuthRequest authRequest = AuthRequest(
      grantType: GrantType.refreshToken.type,
      clientId: AppStrings.clientId,
      refreshToken: authService.appAuth.value.refreshToken,
    );
    Either<AppError, bool> result = await repository.logout(authRequest);
    result.fold((AppError error) {
      //TODO: qualquer outro tratamento aqui
    }, (bool success) async {
      await getIt<AuthService>().clearTokens();
    });
    return result;
  }
}
