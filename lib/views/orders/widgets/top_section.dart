import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/routes/routes.dart';
import 'package:sw_teste/view_model/orders_controller.dart';

class OrdersTopSectionWidget extends Container {
  OrdersTopSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Orders',
          style: TextTheme.of(context).titleLarge,
        ),
        Row(
          children: [
            Text(
              'All',
              style: TextTheme.of(context).bodyLarge,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: context.read<OrdersController>().isFinished,
              builder: (context, value, child) => Transform.scale(
                // scale: .5,
                scaleY: .5,
                scaleX: .6,
                child: Switch(
                  value: value,
                  onChanged: (bool b) async => await context.read<OrdersController>().filterOrders(b),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                Either<AppError, bool> result = await context.read<OrdersController>().logout();
                result.fold(
                  (AppError error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.errorDescription),
                      ),
                    );
                  },
                  (bool success) {
                    context.goNamed(AppRoutes.login);
                  },
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ),
            )
          ],
        ),
      ],
    );
  }
}
