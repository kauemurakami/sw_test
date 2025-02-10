import 'package:sw_teste/view_model/orders.dart';
import 'package:sw_teste/views/orders_view.dart';

import './delegate_imports.dart';

class MyGoRouterDelegate {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;
  GoRouter get router => _router;

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.login.path,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/',
        redirect: (_, state) {
          print(state.fullPath);
          return AppRoutes.login.path;
        },
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login,
        pageBuilder: (_, state) {
          print(state.fullPath);
          return CustomFadeTransition(
            child: ChangeNotifierProvider<LoginController>(
              create: (_) => LoginController(),
              child: LoginPage(),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.orders.path,
        name: AppRoutes.orders,
        pageBuilder: (_, state) {
          print(state.fullPath);
          return CustomFadeTransition(
            child: ChangeNotifierProvider<OrdersController>(
              create: (_) => OrdersController(),
              child: OrdersPage(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.newOrder.path,
            name: AppRoutes.newOrder,
            pageBuilder: (_, state) {
              print(state.fullPath);
              return CustomFadeTransition(
                child: ChangeNotifierProvider<OrdersController>(
                  create: (_) => OrdersController(),
                  child: OrdersPage(),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
