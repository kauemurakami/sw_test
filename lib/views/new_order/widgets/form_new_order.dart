import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/view_model/new_order_controller.dart';
import 'package:sw_teste/view_model/orders_controller.dart';
import 'package:sw_teste/widgets/default_button.dart';
import 'package:sw_teste/widgets/tff.dart';

class FormNewOrderWidget extends StatelessWidget {
  FormNewOrderWidget({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<NewOrderController>(
        builder: (context, NewOrderController controller, child) => Column(
          spacing: 16.0,
          children: [
            Tff(
              label: 'Nome do cliente',
              textColor: Colors.black,
              onChanged: (String value) => controller.onChangedCustomerName(value),
              onSaved: (String value) => controller.onSavedCustomerName(value),
              onValidate: (String value) => controller.validateCustomerName(value),
            ),
            Tff(
              label: 'Descrição',
              textColor: Colors.black,
              onChanged: (String value) => controller.onChangedDescription(value),
              onSaved: (String value) => controller.onSavedDescription(value),
              onValidate: (String value) => controller.validateDescription(value),
            ),
            DefaultButton(
              callback: () async {
                if (_formKey.currentState!.validate()) {
                  final Either<AppError, Order> result = await controller.newOrder();
                  result.fold((AppError error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.errorDescription),
                      ),
                    );
                  }, (Order order) {
                    // context.read<OrdersController>().addNewOrder(order);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Pedido inserido com sucesso.'),
                      ),
                    );
                  });
                }
              },
              text: 'Criar Produto',
            )
          ],
        ),
      ),
    );
  }
}
