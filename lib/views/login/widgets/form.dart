import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/routes/routes.dart';
import 'package:sw_teste/view_model/login_controller.dart';
import 'package:sw_teste/widgets/default_button.dart';
import 'package:sw_teste/widgets/tff.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<LoginController>(
        builder: (context, LoginController controller, child) => Column(
          spacing: 16.0,
          children: [
            Tff(
              label: 'Username',
              onChanged: (String value) => controller.onChangedUsername(value),
              onSaved: (String value) => controller.onSavedUsername(value),
              onValidate: (String value) => controller.validateUsername(value),
            ),
            Tff(
              label: 'Password',
              onChanged: (String value) => controller.onChangedPassword(value),
              onSaved: (String value) => controller.onSavedPassword(value),
              onValidate: (String value) => controller.validatePassword(value),
            ),
            DefaultButton(
              callback: () async {
                if (_formKey.currentState!.validate()) {
                  final Either<AppError, Auth> result = await controller.login();
                  result.fold((AppError error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.errorDescription),
                      ),
                    );
                  }, (Auth auth) {
                    context.goNamed(AppRoutes.orders);
                  });
                }
              },
              text: 'ENTRAR',
            )
          ],
        ),
      ),
    );
  }
}
