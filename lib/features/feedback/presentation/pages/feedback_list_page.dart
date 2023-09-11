import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/theme/app_colors.dart';
import 'package:feedback_app/core/utils/helper/helper_functions.dart';
import 'package:feedback_app/core/utils/widgets/custom_loading_widget.dart';
import 'package:feedback_app/core/utils/widgets/error_widget.dart';
import 'package:feedback_app/core/utils/widgets/logout_dialog.dart';
import 'package:feedback_app/features/feedback/presentation/cubit/feed_back_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/route_names.dart';
import '../../feedback_dependency_injection.dart';
import '../cubit/feed_back_cubit.dart';
import '../widgets/feedback_card_widget.dart';

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({super.key});

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  final FeedBackCubit feedBackCubit = slFeedback<FeedBackCubit>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      feedBackCubit.fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                        return const SizedBox();
                      }, success:
                          (_, __, ___, ____, username, _____, ______, _______) {
                        return Text(
                          username ?? "Unknown",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                          ),
                        );
                      }, orElse: () {
                        return const CustomErrorWidget(errorMsg: 'No userdata');
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FeedBackCubit, FeedbackState>(
                bloc: feedBackCubit,
                builder: (context, state) {
                  return state.maybeWhen(initial: () {
                    feedBackCubit.getInitialFeedbacks();
                    return const CustomLoadingWidget(height: 40, width: 40);
                  }, success:
                      (_, __, ___, ____, _____, ______, _______, feedbackList) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: feedbackList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return FeedbackCardWidget(
                          feedbackModel: feedbackList![index],
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
                  }, orElse: () {
                    return ErrorWidget("Unable to load feedback");
                  });
                }),
            BlocBuilder<FeedBackCubit, FeedbackState>(
                bloc: feedBackCubit,
                builder: (context, state) {
                  return state.maybeWhen(success: (_, __, isLoading, ____,
                      _____, ______, _______, ________) {
                    if (isLoading ?? false) {
                      return const CustomLoadingWidget(height: 25, width: 25);
                    } else {
                      return const SizedBox();
                    }
                  }, orElse: () {
                    return const SizedBox();
                  });
                })
          ],
        ),
      ),
    ));
  }
}
