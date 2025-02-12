import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/routes/routes.dart';
import 'package:sw_teste/view_model/orders_controller.dart';
import 'package:sw_teste/views/orders/widgets/order_item.dart';
import 'package:sw_teste/views/orders/widgets/top_section.dart';
import 'package:sw_teste/widgets/error_widget.dart';
import 'package:sw_teste/widgets/loading.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.newOrder);
        },
        child: Icon(
          Icons.add,
          size: 24.0,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrdersTopSectionWidget(),
                FutureBuilder(
                  future: context.read<OrdersController>().fetchOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingWidget();
                    } else if (snapshot.hasError) {
                      return AppErroWidget(
                        callback: () async {
                          context.read<OrdersController>().fetchOrders();
                        },
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data!.fold(
                        (AppError error) {
                          return AppErroWidget(
                            message: error.errorDescription,
                            callback: () => context.goNamed(AppRoutes.login),
                          );
                        },
                        (List<Order> orders) {
                          if (orders.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text('Você não possui nenhum pedido até o momento.'),
                                )
                              ],
                            );
                          } else {
                            return ValueListenableBuilder(
                              valueListenable: context.read<OrdersController>().orders,
                              builder: (context, value, child) => ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.length,
                                itemBuilder: (_, index) => OrderItemWidget(
                                  order: value[index],
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
