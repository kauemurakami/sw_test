import 'package:flutter/material.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/repository/orders_repository.dart';

class OrdersController with ChangeNotifier {
  final OrdersRepository repository = OrdersRepository();
  ValueNotifier<List<Order>> orders = ValueNotifier(<Order>[]);
  ValueNotifier<bool> isFinished = ValueNotifier(true);
  ValueNotifier<bool> load = ValueNotifier(true);

  OrdersController() {
    print('init orders controller');
    fetchOrders();
  }

  Future<Either<AppError, List<Order>>> fetchOrders() async {
    print('fetchOrdersController');
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
}
