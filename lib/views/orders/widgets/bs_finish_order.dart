import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/view_model/orders_controller.dart';
import 'package:sw_teste/widgets/default_button.dart';

class BSFinishOrderWidget extends StatelessWidget {
  const BSFinishOrderWidget({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      height: MediaQuery.sizeOf(context).height / 3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Finalizar pedido de ${order.customerName}?',
            style: TextTheme.of(context).titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultButton(color: Colors.red, callback: () => Navigator.pop(context), text: 'Cancelar'),
              DefaultButton(
                  callback: () async {
                    final result = await context.read<OrdersController>().finishOrder(order);
                    result.fold((AppError error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.errorDescription),
                        ),
                      );
                      Navigator.pop(context);
                    }, (Order order) {
                      Navigator.pop(context);
                    });
                  },
                  text: 'Finalizar'),
            ],
          )
        ],
      ),
    );
  }
}
