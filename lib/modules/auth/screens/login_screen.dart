// screens/login_screen.dart
import 'package:custos_task/modules/auth/provider/auth_provider.dart';
import 'package:custos_task/shared/custom_button.dart';
import 'package:custos_task/shared/custom_textfield.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';

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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Palette.kWhiteColor,
            fontSize: 20,
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
                        width: width * 0.1,
                        child: CustomButton(
                          loading: value.isLoading,
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
                        child: const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Palette.kBlueColor,
                            fontSize: 10,
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
    );
  }
}
