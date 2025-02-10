import 'package:sw_teste/services/api.dart';
import 'package:sw_teste/services/setup_locator.dart';

class OrdersRepository {
  final ApiService api = getIt<ApiService>();

  fetchOrders({bool isFinished = false}) async => api.fetchOrders(isFinished: isFinished);
}
