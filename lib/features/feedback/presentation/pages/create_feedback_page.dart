import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/utils/validators/app_validators.dart';
import 'package:feedback_app/core/utils/widgets/custom_elevated_button.dart';
import 'package:feedback_app/core/utils/widgets/custom_textfield.dart';
import 'package:feedback_app/core/utils/widgets/error_widget.dart';
import 'package:feedback_app/features/authentication/presentation/widgets/app_logo_widget.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/feedback_dependency_injection.dart';
import 'package:feedback_app/features/feedback/presentation/cubit/feed_back_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/feed_back_state.dart';

class CreateFeedBackPage extends StatelessWidget {
  CreateFeedBackPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _reporterNameController = TextEditingController();
  final FeedBackCubit feedBackCubit = slFeedback<FeedBackCubit>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppConstants.createFeedbackTitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogoWidget(message: "Give Feedback"),
                20.Vspace,
                CustomTextField(
                  labelText: "Title",
                  controller: _titleController,
                  validator: (value) => AppValidators.emptyTextValidator(value),
                ),
                20.Vspace,
                CustomTextField(
                  labelText: "Description",
                  controller: _descController,
                  validator: (value) => AppValidators.emptyTextValidator(value),
                ),
                20.Vspace,
                Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  child: BlocBuilder<FeedBackCubit, FeedbackState>(
                      bloc: feedBackCubit,
                      builder: (context, state) {
                        return state.when(initial: () {
                          //fetch category first time
                          feedBackCubit.getFeedbackCategories();
                          return const SizedBox(
                            height: 50,
                            width: double.maxFinite,
                            child: Text("Fetching categories..."),
                          );
                        }, failure: (failureMsg) {
                          return const CustomErrorWidget(
                              errorMsg: "Failed to fetch categories");
                        }, success: (_, __, ___, ____, _____, selectedCategory,
                            categories, ______) {
                          return DropdownButton<String>(
                            underline: const SizedBox.shrink(),
                            value: selectedCategory,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            elevation: 16,
                            style:
                                const TextStyle(color: AppColors.darkBlueColor),
                            onChanged: (String? value) {
                              feedBackCubit.changeCategory(value);
                            },
                            items: categories!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        });
                      }),
                ),
                Row(
                  children: [
                    BlocBuilder<FeedBackCubit, FeedbackState>(
                        bloc: feedBackCubit,
                        builder: (context, state) {
                          return state.when(initial: () {
                            return _buildAnonymousCheckBox(isSelected: true);
                          }, failure: (failureMsg) {
                            return _buildAnonymousCheckBox(isSelected: true);
                          }, success: (isAnonymous, _, __, ____, _____, ______,
                              _______, ________) {
                            return _buildAnonymousCheckBox(
                                isSelected: isAnonymous ?? true);
                          });
                        }),
                    const Text("Give Anonymous feedback")
                  ],
                ),
                BlocBuilder<FeedBackCubit, FeedbackState>(
                    bloc: feedBackCubit,
                    builder: (context, state) {
                      if (state is FeedbackSuccess) {
                        return Visibility(
                          visible: !state.isAnonymous!,
                          child: CustomTextField(
                            labelText: "Reporter Name",
                            controller: _reporterNameController,
                            validator: (value) =>
                                AppValidators.emptyTextValidator(value),
                          ),
                        );
                      } else {
                        return CustomTextField(
                          labelText: "Reporter Name",
                          controller: _reporterNameController,
                          validator: (value) =>
                              AppValidators.emptyTextValidator(value),
                        );
                      }
                    }),
                20.Vspace,
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          feedBackCubit
                              .createNewFeedback(FeedbackModel(
                            id: const Uuid().v1(),
                            time: DateTime.now().toUtc().toString(),
                            title: _titleController.text.trim(),
                            description: _descController.text.trim(),
                            likes: [],
                            dislikes: [],
                            reporterName: _reporterNameController.text.trim(),
                          ))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Feedback created successfully!!")));
                            context.pop();
                          });
                        }
                      },
                      btnText: "Give Feedback"),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildAnonymousCheckBox({required bool isSelected}) {
    return Checkbox(
        activeColor: AppColors.navyBlueColor,
        value: isSelected,
        onChanged: (value) {
          feedBackCubit.changeReporterVisibility(value);
        });
  }
}
