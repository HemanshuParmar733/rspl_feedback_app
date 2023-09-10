import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/navigation/route_names.dart';
import 'package:feedback_app/core/utils/helper/helper_functions.dart';
import 'package:feedback_app/core/utils/validators/app_validators.dart';
import 'package:feedback_app/core/utils/widgets/custom_elevated_button.dart';
import 'package:feedback_app/core/utils/widgets/custom_textfield.dart';
import 'package:feedback_app/features/authentication/auth_dependency_injection.dart';
import 'package:feedback_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:feedback_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:feedback_app/features/authentication/presentation/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/widgets/loding_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthCubit authCubit = slAuth<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocListener(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.isLoading != null && state.isLoading!) {
              showLoadingDialog(
                  context: context,
                  title: "Please wait",
                  message: "Loading...");
            }
            if (state.isLoading != null &&
                !state.isLoading! &&
                !state.isLogin!) {
              hideLoadingDialog(context: context);
            }

            if (state.isLogin!) {
              context.pushReplacement(getRoutePath(RouteNames.feedbackList));
            }
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMsg ?? "Something went wrong.")));
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogoWidget(
                      message: "Welcome",
                    ),
                    20.Vspace,
                    CustomTextField(
                        labelText: "Email",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            AppValidators.emailValidator(value),
                        controller: _emailController),
                    20.Vspace,
                    BlocBuilder<AuthCubit, AuthState>(
                        bloc: authCubit,
                        builder: (context, state) {
                          return state.when(initial: () {
                            return _buildPassWordTextField(true);
                          }, failure: (failureMsg) {
                            return _buildPassWordTextField(false);
                          }, success: (passWordObscure, confirmPassObscure, _,
                              __, ___) {
                            return _buildPassWordTextField(passWordObscure!);
                          });
                        }),
                    10.Vspace,
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text("forgot password?")),
                    ),
                    10.Vspace,
                    SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: CustomElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                authCubit.loginWithEmailPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                              }
                            },
                            btnText: "Login")),
                    10.Vspace,
                    OutlinedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.maxFinite, 50)),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: AppColors.darkBlueColor,
                                width: 1.0,
                                style: BorderStyle.solid))),
                        onPressed: () {
                          context.pushReplacement(
                              getRoutePath(RouteNames.register));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: AppColors.navyBlueColor),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildPassWordTextField(bool isObscure) {
    return CustomTextField(
        labelText: "Password",
        obscure: isObscure,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            authCubit.togglePasswordVisibility(isObscure);
          },
        ),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => AppValidators.passwordValidator(value),
        controller: _passwordController);
  }
}
