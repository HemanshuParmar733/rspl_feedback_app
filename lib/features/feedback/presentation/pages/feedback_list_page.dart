import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/theme/app_colors.dart';
import 'package:feedback_app/core/utils/helper/helper_functions.dart';
import 'package:feedback_app/core/utils/widgets/error_widget.dart';
import 'package:feedback_app/core/utils/widgets/logout_dialog.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/presentation/cubit/feed_back_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/route_names.dart';
import '../../feedback_dependency_injection.dart';
import '../cubit/feed_back_cubit.dart';
import '../widgets/feedback_card_widget.dart';

class FeedbackListPage extends StatelessWidget {
  FeedbackListPage({super.key});

  final FeedBackCubit feedBackCubit = slFeedback<FeedBackCubit>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.navyBlueColor,
          onPressed: () {
            context.push(getRoutePath(RouteNames.createFeedback));
          },
          label: Row(
            children: [
              const Icon(
                Icons.edit,
                size: 20,
              ),
              4.Hspace,
              const Text("Give Feedback"),
            ],
          )),
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.comment),
            10.Hspace,
            Text(AppConstants.feedbackListTitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ))
          ],
        ),
        backgroundColor: AppColors.navyBlueColor,
        actions: [
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<FeedBackCubit, FeedbackState>(
                    bloc: feedBackCubit,
                    builder: (context, state) {
                      return state.maybeWhen(initial: () {
                        feedBackCubit.getUsername();
                        return SizedBox();
                      }, success: (_, __, ___, ____, username, _____, ______) {
                        return Text(
                          username ?? "Unknown",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                          ),
                        );
                      }, orElse: () {
                        return CustomErrorWidget(errorMsg: 'No userdata');
                      });
                    }),
                IconButton(
                  icon: const Icon(Icons.logout,
                      size: 24, color: AppColors.greyolor),
                  onPressed: () {
                    showLogoutDialog(context);
                    // showLoadingDialog(context: context,title: "demo",message: 'eef');
                  },
                )
              ],
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: feedBackCubit.getAllFeedbackStream(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: AppColors.navyBlueColor,
                    )));
          }

          if (snapshot.data == null) {
            return const Text(
              "No data found.",
              style: TextStyle(fontSize: 20),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              "No Feedbacks",
              style: TextStyle(fontSize: 20, color: AppColors.darkBlueColor),
            ));
          }

          if (snapshot.hasData) {
            final List<FeedbackModel> feedbackList =
                feedBackCubit.getFeedbackModelList(snapshot.data?.docs);

            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: feedbackList.length,
              itemBuilder: (context, index) {
                return FeedbackCardWidget(
                  feedbackModel: feedbackList[index],
                  userId: FirebaseAuth.instance.currentUser?.uid,
                  onLikeTapped: () {
                    feedBackCubit.updateFeedback(
                        feedbackList[index], UserAction.like);
                  },
                  onDisLikeTapped: () {
                    feedBackCubit.updateFeedback(
                        feedbackList[index], UserAction.dislike);
                  },
                );
              },
            );
          }

          return const CustomErrorWidget(errorMsg: "Failed to load feedbacks.");
        }),
      ),
    ));
  }
}
