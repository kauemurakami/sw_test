import 'package:flutter/material.dart';
import 'package:sw_teste/widgets/default_button.dart';

class AppErroWidget extends Container {
  AppErroWidget({super.key, this.message, this.callback});
  final String? message;
  final VoidCallback? callback;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
              message ?? 'Ocorreu um erro inesperado, por favor, tente novamente ou entre em contato com o suporte'),
        ),
        callback == null ? const SizedBox.shrink() : DefaultButton(callback: callback!, text: 'TENTAR NOVAMENTE')
      ],
    );
  }
}
