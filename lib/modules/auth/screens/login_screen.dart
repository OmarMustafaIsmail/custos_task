import 'package:auto_size_text/auto_size_text.dart';
import 'package:custos_task/modules/auth/provider/auth_provider.dart';
import 'package:custos_task/shared/custom_button.dart';
import 'package:custos_task/shared/custom_textfield.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  Future<void> _login(BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
     await Provider.of<AuthProvider>(context, listen: false).login(
        _emailController.text,
        _passwordController.text,
       context: context
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AutoSizeText(
            'Login',
            style: TextStyle(
              color: Palette.kWhiteColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          // leadingWidth: width * 0.08,
          // leading: SvgPicture.asset(
          //   'assets/icons/custos_logo.svg',
          //   colorFilter: const ColorFilter.mode(
          //     Palette.kWhiteColor,
          //     BlendMode.srcATop,
          //   ),
          // ),
          backgroundColor: Palette.kAppBarColor,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(
              flex: 5,
              child: Form(
                key: _loginFormKey,
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

                          child: CustomButton(
                            loading: value.isLoadingLogin,
                            radius: 10,
                            size: 15,
                            buttonText: 'Login',
                            onPressed: () => _login(context),
                            buttonColor: ButtonColor.primary,
                            height: height * 0.05,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () => context.push('/register'),
                          child: const AutoSizeText(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: Palette.kBlueColor,
                              // fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
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
      ),
    );
  }
}
