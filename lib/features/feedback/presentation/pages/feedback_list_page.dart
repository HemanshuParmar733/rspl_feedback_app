import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/core/theme/app_colors.dart';
import 'package:feedback_app/core/utils/widgets/custom_loading_widget.dart';
import 'package:feedback_app/core/utils/widgets/error_widget.dart';
import 'package:feedback_app/core/utils/widgets/logout_dialog.dart';
import 'package:feedback_app/features/feedback/presentation/pages/create_feedback_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../feedback_dependency_injection.dart';
import '../bloc/feedback_bloc.dart';
import '../widgets/feedback_card_widget.dart';

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({super.key});

  static const String feedbackListRoute = '/feedbackList';

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  final FeedbackBloc feedBackBloc = slFeedback<FeedbackBloc>();

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
      feedBackBloc.add(OnPaginationNextPageEvent());
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
          onPressed: () async {
            bool? isCreated =
                await context.push(CreateFeedBackPage.createFeedbackRoute);

            if (isCreated != null && isCreated) {
              feedBackBloc.add(const OnGetLatestFeedbackEvent());
            }
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
        title: Text(AppConstants.feedbackListTitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16)),
        backgroundColor: AppColors.navyBlueColor,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<FeedbackBloc, FeedbackState>(
                  bloc: feedBackBloc..add(OnGetUserDataEvent()),
                  builder: (context, state) {
                    if (state.feedbackListStatus ==
                        FeedbackStatus.feedbackInitial) {
                      return const SizedBox();
                    } else if (state.feedbackListStatus ==
                        FeedbackStatus.feedbackSuccess) {
                      return Text(
                        state.username ?? "Unknown",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      );
                    } else if (state.feedbackListStatus ==
                        FeedbackStatus.feedbackLoading) {
                      return const SizedBox();
                    } else if (state.feedbackListStatus ==
                        FeedbackStatus.feedbackFailure) {
                      return CustomErrorWidget(
                          errorMsg: state.failureMsg ?? "No user data.");
                    } else {
                      return const SizedBox();
                    }
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
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<FeedbackBloc, FeedbackState>(
                bloc: feedBackBloc..add(const OnGetLatestFeedbackEvent()),
                builder: (context, state) {
                  if (state.feedbackListStatus ==
                          FeedbackStatus.feedbackInitial ||
                      state.feedbackListStatus ==
                          FeedbackStatus.feedbackLoading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / 2 - 100),
                      child: const CustomLoadingWidget(height: 40, width: 40),
                    );
                  } else if (state.feedbackListStatus ==
                          FeedbackStatus.feedbackSuccess &&
                      state.feedbackModelList!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: state.feedbackModelList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return FeedbackCardWidget(
                          feedbackModel: state.feedbackModelList![index],
                          userId: FirebaseAuth.instance.currentUser?.uid,
                          onLikeTapped: () {
                            feedBackBloc.add(OnUpdateFeedbackEvent(
                              feedbackModel: state.feedbackModelList![index],
                              userAction: UserAction.like,
                            ));
                          },
                          onDisLikeTapped: () {
                            feedBackBloc.add(OnUpdateFeedbackEvent(
                              feedbackModel: state.feedbackModelList![index],
                              userAction: UserAction.dislike,
                            ));
                          },
                        );
                      },
                    );
                  } else if (state.feedbackListStatus ==
                      FeedbackStatus.feedbackFailure) {
                    return CustomErrorWidget(
                        errorMsg: state.failureMsg ??
                            "Failed to display feedback list.");
                  } else {
                    return const SizedBox();
                  }
                }),
            BlocBuilder<FeedbackBloc, FeedbackState>(
                bloc: feedBackBloc,
                builder: (context, state) {
                  if (feedBackBloc.state.paginationStatus ==
                      FeedbackStatus.feedbackLoading) {
                    return const CustomLoadingWidget(height: 30, width: 30);
                  } else if (state.paginationStatus ==
                      FeedbackStatus.feedbackSuccess) {
                    return const SizedBox();
                  } else if (state.paginationStatus ==
                      FeedbackStatus.feedbackFailure) {
                    return CustomErrorWidget(
                        errorMsg: state.failureMsg ??
                            "Failed to display pagination circular progress.");
                  } else {
                    return const SizedBox();
                  }
                }),
            80.Vspace
          ],
        ),
      ),
    ));
  }
}
