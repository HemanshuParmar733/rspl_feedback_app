import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/utils/validators/app_validators.dart';
import 'package:feedback_app/core/utils/widgets/custom_elevated_button.dart';
import 'package:feedback_app/core/utils/widgets/custom_textfield.dart';
import 'package:feedback_app/features/authentication/presentation/widgets/app_logo_widget.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/feedback_dependency_injection.dart';
import 'package:feedback_app/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_colors.dart';

class CreateFeedBackPage extends StatelessWidget {
  CreateFeedBackPage({super.key});

  static const String createFeedbackRoute = '/createFeedback';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _reporterNameController = TextEditingController();
  final FeedbackBloc feedBackBloc = slFeedback<FeedbackBloc>()
    ..add(OnGetUserDataEvent());
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
            body: BlocListener<FeedbackBloc, FeedbackState>(
                bloc: feedBackBloc,
                listener: (context, state) {
                  if (feedBackBloc.state.isFeedbackCreate ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Feedback created successfully!!")));
                    context.pop(true);
                  }
                },
                child: SingleChildScrollView(
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
                            validator: (value) =>
                                AppValidators.emptyTextValidator(value),
                          ),
                          20.Vspace,
                          CustomTextField(
                            labelText: "Description",
                            controller: _descController,
                            validator: (value) =>
                                AppValidators.emptyTextValidator(value),
                          ),
                          20.Vspace,
                          Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            child: BlocBuilder<FeedbackBloc, FeedbackState>(
                                bloc: feedBackBloc
                                  ..add(const OnGetAllFeedbackCategoryEvent()),
                                builder: (context, state) {
                                  if (state.feedbackCategoryStatus ==
                                          FeedbackStatus.feedbackInitial ||
                                      state.feedbackCategoryStatus ==
                                          FeedbackStatus.feedbackLoading) {
                                    return const SizedBox(
                                      height: 50,
                                      width: double.maxFinite,
                                      child: Text("Fetching categories..."),
                                    );
                                  } else if (state.feedbackCategoryStatus ==
                                      FeedbackStatus.feedbackSuccess) {
                                    return DropdownButton<String>(
                                      underline: const SizedBox.shrink(),
                                      value: state.selectedCategory,
                                      isExpanded: true,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_outlined),
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: AppColors.darkBlueColor),
                                      onChanged: (String? value) {
                                        feedBackBloc.add(OnCategoryChangeEvent(
                                            category: value ?? 'Other'));
                                      },
                                      items: state.feedbackCategories != null
                                          ? state.feedbackCategories!
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList()
                                          : [],
                                    );
                                  } else if (state.feedbackCategoryStatus ==
                                      FeedbackStatus.feedbackFailure) {
                                    return Text(state.failureMsg ??
                                        "failed to load categories");
                                  } else {
                                    return Text(state.failureMsg ??
                                        "failed to load categories");
                                  }
                                }),
                          ),
                          Row(
                            children: [
                              BlocBuilder<FeedbackBloc, FeedbackState>(
                                  bloc: feedBackBloc,
                                  builder: (context, state) {
                                    return _buildAnonymousCheckBox(
                                        isSelected: state.isAnonymous ?? false);
                                  }),
                              const Text("Give Anonymous feedback")
                            ],
                          ),
                          BlocBuilder<FeedbackBloc, FeedbackState>(
                              bloc: feedBackBloc,
                              builder: (context, state) {
                                return Visibility(
                                  visible: !(state.isAnonymous ?? false),
                                  child: CustomTextField(
                                    labelText: "Reporter Name",
                                    controller: _reporterNameController,
                                    validator: (value) =>
                                        AppValidators.emptyTextValidator(value),
                                  ),
                                );
                              }),
                          20.Vspace,
                          SizedBox(
                            height: 50,
                            width: double.maxFinite,
                            child: CustomElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    feedBackBloc.add(OnCreateNewFeedbackEvent(
                                        feedbackModel: FeedbackModel(
                                      id: const Uuid().v1(),
                                      time: DateTime.now().toUtc().toString(),
                                      title: _titleController.text.trim(),
                                      description: _descController.text.trim(),
                                      likes: const [],
                                      dislikes: const [],
                                      reporterName:
                                          _reporterNameController.text.trim(),
                                    )));
                                  }
                                },
                                btnText: "Give Feedback"),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  Widget _buildAnonymousCheckBox({required bool isSelected}) {
    return Checkbox(
        activeColor: AppColors.navyBlueColor,
        value: isSelected,
        onChanged: (value) {
          feedBackBloc.add(OnAnonymousChangeEvent(isAnonymous: value ?? false));
        });
  }
}
