import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/services/api.dart';
import 'package:sw_teste/services/setup_locator.dart';

class NewOrderRepository {
  final ApiService api = getIt<ApiService>();

  Future<Either<AppError, Order>> newOrder(Order order) async => await api.newOrder(order);
}
