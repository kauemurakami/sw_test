import 'package:flutter/material.dart';
import 'package:sw_teste/views/new_order/widgets/form_new_order.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(),
                Text(
                  'New Order',
                  style: TextTheme.of(context).titleLarge,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormNewOrderWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
