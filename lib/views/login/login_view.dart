import 'package:sw_teste/constants/colors.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/routes/delegate/delegate_imports.dart';
import 'package:sw_teste/widgets/default_button.dart';
import 'package:sw_teste/widgets/tff.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.startPurple, AppColors.endPurple],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Image.asset('assets/logo.png'),
                Form(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
