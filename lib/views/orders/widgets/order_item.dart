import 'package:flutter/material.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/utils/functions/format_date.dart';
import 'package:sw_teste/views/orders/widgets/bs_finish_order.dart';

class OrderItemWidget extends Container {
  OrderItemWidget({
    super.key,
    required this.order,
  });
  final Order order;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('finishorder');
        await showModalBottomSheet(
          isDismissible: true,
          enableDrag: true,
          context: context,
          builder: (context) => BSFinishOrderWidget(order: order),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          border: Border.all(
            width: .6,
            color: Colors.deepPurple,
          ),
        ),
        child: Column(
          spacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.customerName,
                  style: TextTheme.of(context).titleMedium,
                ),
                Text(
                  formatDate(order.createdAt),
                  style: TextTheme.of(context).labelSmall,
                ),
              ],
            ),
            Row(
              children: [
                Flexible(child: Text(order.description)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Finalizar pedido',
                  style: TextTheme.of(context)
                      .bodyMedium!
                      .copyWith(decoration: TextDecoration.underline, color: Colors.deepPurple),
                ),
                Text(
                  order.finished ? 'Finalizado' : 'Pendente',
                  style: TextTheme.of(context).labelSmall!.copyWith(
                        color: order.finished ? Colors.green : Colors.deepOrange,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
