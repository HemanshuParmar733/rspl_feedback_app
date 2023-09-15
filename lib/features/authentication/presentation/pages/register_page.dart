import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/utils/validators/app_validators.dart';
import 'package:feedback_app/core/utils/widgets/custom_elevated_button.dart';
import 'package:feedback_app/core/utils/widgets/custom_textfield.dart';
import 'package:feedback_app/core/utils/widgets/loding_dialog.dart';
import 'package:feedback_app/features/authentication/auth_dependency_injection.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:feedback_app/features/authentication/presentation/pages/login_page.dart';
import 'package:feedback_app/features/authentication/presentation/widgets/app_logo_widget.dart';
import 'package:feedback_app/features/feedback/presentation/pages/feedback_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String registerRoute = '/register';

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
  final AuthBloc authBloc = slAuth<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(LoginPage.loginRoute);
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: GestureDetector(
              onTap: () {
                context.pushReplacement(LoginPage.loginRoute);
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
        body: BlocListener<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            if (state.authStatus == AuthStatus.authLoading) {
              showLoadingDialog(
                  context: context,
                  title: "Please wait",
                  message: "Loading...");
            }
            if (state.authStatus == AuthStatus.authSuccess &&
                state.isRegister != null &&
                state.isRegister!) {
              hideLoadingDialog(context: context);
              context.pushReplacement(FeedbackListPage.feedbackListRoute);
            }

            if (state.authStatus == AuthStatus.authFailure) {
              hideLoadingDialog(context: context);

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
                      BlocBuilder<AuthBloc, AuthState>(
                          bloc: authBloc,
                          builder: (context, state) {
                            return _buildPassWordTextField(
                                isConfirmPassField: false,
                                isObscure: state.obscurePassword ?? true,
                                controller: _passwordController);
                          }),
                      20.Vspace,
                      BlocBuilder<AuthBloc, AuthState>(
                          bloc: authBloc,
                          builder: (context, state) {
                            return _buildPassWordTextField(
                                isObscure: state.obscureConfirmPassword ?? true,
                                controller: _confirmPasswordController,
                                isConfirmPassField: true);
                          }),
                      20.Vspace,
                      SizedBox(
                          height: 50,
                          width: double.maxFinite,
                          child: CustomElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  authBloc.add(OnRegisterEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      userModel: UserModel(
                                          email: _emailController.text.trim(),
                                          username:
                                              _nameController.text.trim())));
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
              authBloc.add(
                  OnToggleConfirmPasswordVisibilityEvent(value: isObscure));
            } else {
              authBloc.add(OnTogglePasswordVisibilityEvent(value: isObscure));
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
}
