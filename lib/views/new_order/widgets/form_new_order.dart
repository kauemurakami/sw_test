import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/order.dart';
import 'package:sw_teste/view_model/new_order_controller.dart';
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
              label: 'Descrição',
            ),
            DefaultButton(
              callback: () async {
                print('criar produto');
                if (_formKey.currentState!.validate()) {
                  final Either<AppError, Order> result = await controller.newOrder();
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
