
import './delegate_imports.dart';

class MyGoRouterDelegate {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    // initialLocation: AppRoutes.login.path,
    initialLocation: AppRoutes.orders.path,
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
        parentNavigatorKey: _rootNavigatorKey,
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
        parentNavigatorKey: _rootNavigatorKey,
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
                child: ChangeNotifierProvider<NewOrderController>(
                  create: (_) => NewOrderController(),
                  child: NewOrderPage(),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
