import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/services/api.dart';
import 'package:sw_teste/services/setup_locator.dart';

class OrdersRepository {
  final ApiService api = getIt<ApiService>();

  Future<Either<AppError, List<Order>>> fetchOrders({bool isFinished = true}) async =>
      api.fetchOrders(isFinished: isFinished);

  Future<Either<AppError, Order>> finishOrder(Order order) => api.finishOrder(order);
}
