import 'package:flutter/material.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/repository/new_order_repository.dart';

class NewOrderController with ChangeNotifier {
  final NewOrderRepository repository = NewOrderRepository();

  Future<Either<AppError, Order>> newOrder() async {
    return Either.left(AppError(error: 'error', errorDescription: 'errorDescription'));
  }
}
