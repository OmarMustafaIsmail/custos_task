import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/modules/auth/provider/auth_provider.dart';
import 'package:custos_task/shared/custom_button.dart';
import 'package:custos_task/shared/custom_textfield.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  RegisterScreen({super.key});
  Future<void> _register(BuildContext context) async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      await Provider.of<AuthProvider>(context, listen: false).register(
          _emailController.text, _passwordController.text,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back,
            color: Palette.kWhiteColor,
          ),
        ),
        title: const AutoSizeText(
          'Register',
          style: TextStyle(
            color: Palette.kWhiteColor,
            // fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        // leadingWidth: width * 0.08,

        backgroundColor: Palette.kAppBarColor,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Container()),
          Expanded(
            flex: 5,
            child: Form(
              key: _registerFormKey,
              child: Consumer<AuthProvider>(
                builder:
                    (BuildContext context, AuthProvider value, Widget? child) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        labelText: 'Email',
                        validator: (String? s) {
                          if (!AuthProvider.isEmail(s!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        labelText: 'Password',
                        validator: (String? s) {
                          if (s!.isEmpty || s.length < 8) {
                            return 'Password should be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.1,
                        child: CustomButton(
                          loading: value.isLoadingRegister,
                          radius: 10,
                          size: 15,
                          buttonText: 'Register',
                          onPressed: () => _register(context),
                          buttonColor: ButtonColor.primary,
                          height: height * 0.05,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(flex: 3, child: Container()),
        ],
      ),
    );
  }
}
