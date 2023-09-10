import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/utils/helper/helper_functions.dart';
import 'package:feedback_app/core/utils/validators/app_validators.dart';
import 'package:feedback_app/core/utils/widgets/custom_elevated_button.dart';
import 'package:feedback_app/core/utils/widgets/custom_textfield.dart';
import 'package:feedback_app/core/utils/widgets/error_widget.dart';
import 'package:feedback_app/core/utils/widgets/loding_dialog.dart';
import 'package:feedback_app/features/authentication/auth_dependency_injection.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:feedback_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:feedback_app/features/authentication/presentation/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthCubit authCubit = slAuth<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(getRoutePath(RouteNames.login));
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: GestureDetector(
              onTap: () {
                context.pushReplacement(getRoutePath(RouteNames.login));
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.whiteColor,
              )),
          title: const Text(
            "Create New Account",
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
        body: BlocListener<AuthCubit, AuthState>(
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
                  !state.isRegister!) {
                hideLoadingDialog(context: context);
              }
              if (state.isRegister != null && state.isRegister!) {
                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>), (route) => false)
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppLogoWidget(
                        message: "Create New Account",
                      ),
                      20.Vspace,
                      CustomTextField(
                          labelText: "UserName",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              AppValidators.nameValidator(value),
                          controller: _nameController),
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
                              return _buildPassWordTextField(
                                  isConfirmPassField: false,
                                  isObscure: true,
                                  controller: _passwordController);
                            }, failure: (failureMsg) {
                              return _buildPassWordTextField(
                                  isConfirmPassField: false,
                                  isObscure: true,
                                  controller: _passwordController);
                            }, success:
                                (passObscure, confirmPassObscure, _, __, ___) {
                              return _buildPassWordTextField(
                                  controller: _passwordController,
                                  isConfirmPassField: false,
                                  isObscure: passObscure!);
                            });
                          }),
                      20.Vspace,
                      BlocBuilder<AuthCubit, AuthState>(
                          bloc: authCubit,
                          builder: (context, state) {
                            return state.when(initial: () {
                              return _buildPassWordTextField(
                                  isObscure: true,
                                  controller: _confirmPasswordController,
                                  isConfirmPassField: true);
                            }, failure: (failureMsg) {
                              return _buildPassWordTextField(
                                  isObscure: true,
                                  controller: _confirmPasswordController,
                                  isConfirmPassField: true);
                            }, success:
                                (passObscure, confirmPassObscure, _, __, ___) {
                              return _buildPassWordTextField(
                                  isObscure: confirmPassObscure!,
                                  controller: _confirmPasswordController,
                                  isConfirmPassField: true);
                            });
                          }),
                      20.Vspace,
                      SizedBox(
                          height: 50,
                          width: double.maxFinite,
                          child: CustomElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  authCubit.registerNewUser(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      model: UserModel(
                                          email: _emailController.text.trim(),
                                          username:
                                              _nameController.text.trim()));
                                }
                              },
                              btnText: "Register"))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildPassWordTextField(
      {required bool isObscure,
      required bool isConfirmPassField,
      required TextEditingController controller}) {
    return CustomTextField(
        labelText: isConfirmPassField ? "Confirm Password" : "Password",
        obscure: isObscure,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            if (isConfirmPassField) {
              authCubit.toggleConfirmPasswordVisibility(isObscure);
            } else {
              authCubit.togglePasswordVisibility(isObscure);
            }
          },
        ),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => isConfirmPassField
            ? AppValidators.confirmPasswordValidator(
                actualPass: _confirmPasswordController.text,
                anotherPass: _passwordController.text.trim())
            : AppValidators.confirmPasswordValidator(
                actualPass: _passwordController.text,
                anotherPass: _confirmPasswordController.text.trim()),
        controller: controller);
  }

  Widget _buildErrorWidget(String? failureMsg) {
    return CustomErrorWidget(
        errorMsg: failureMsg ?? "Unable to load password field");
  }
}
