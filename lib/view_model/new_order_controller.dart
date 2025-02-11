import 'package:flutter/material.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/repository/new_order_repository.dart';

class NewOrderController with ChangeNotifier {
  final NewOrderRepository repository = NewOrderRepository();
  ValueNotifier<Order> order = ValueNotifier(Order());

  Future<Either<AppError, Order>> newOrder() async {
    final Either<AppError, Order> result = await repository.newOrder(order.value);
    result.fold((error) {
      //TODO: qualquer outro tratamento aqui
    }, (Order order) {
      this.order.value = order;
    });
    return result;
  }

  onChangedCustomerName(String value) => order.value.customerName = value;
  onSavedCustomerName(String value) => order.value.customerName = value;
  validateCustomerName(String value) => value.length < 3 ? 'Insira um nome válido' : null;
  onChangedDescription(String value) => order.value.description = value;
  onSavedDescription(String value) => order.value.description = value;
  validateDescription(String value) => value.length < 5 ? 'Insira uma descrição válida' : null;
}
