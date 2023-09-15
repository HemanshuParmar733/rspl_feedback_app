import 'package:feedback_app/core/extensions/context_extensions.dart';
import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import 'custom_text_widget.dart';

class FeedbackCardWidget extends StatelessWidget {
  const FeedbackCardWidget(
      {super.key,
      required this.feedbackModel,
      required this.onLikeTapped,
      required this.onDisLikeTapped,
      this.userId});

  final FeedbackModel feedbackModel;
  final String? userId;
  final VoidCallback onLikeTapped;
  final VoidCallback onDisLikeTapped;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.lightBlueColor,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    feedbackModel.userName ?? "Username",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(DateFormat.yMMMEd()
                    .format(DateTime.parse(feedbackModel.time!)))
              ],
            ),
            10.Vspace,
            FeedbackCardText(
                text: feedbackModel.title ?? "Feedback Title",
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                maxLines: 1,
                textColor: Colors.black87),
            8.Vspace,
            FeedbackCardText(
                text: feedbackModel.description ?? "Feedback Description",
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                maxLines: 2,
                textColor: Colors.black54),
            20.Vspace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.category,
                  color: context.isDarkMode
                      ? AppColors.whiteColor
                      : AppColors.navyBlueColor,
                  size: 20,
                ),
                8.Hspace,
                FeedbackCardText(
                    text: feedbackModel.category ?? "category",
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textColor: AppColors.darkBlueColor),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: context.isDarkMode
                      ? AppColors.whiteColor
                      : AppColors.navyBlueColor,
                  size: 20,
                ),
                8.Hspace,
                FeedbackCardText(
                    text: feedbackModel.reporterName ?? "Reporter",
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textColor: AppColors.darkBlueColor),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: onLikeTapped,
                    child: Icon(
                      feedbackModel.likes!.contains(userId)
                          ? Icons.thumb_up
                          : Icons.thumb_up_off_alt,
                      color: AppColors.darkBlueColor,
                    )),
                4.Hspace,
                Text(
                  '${feedbackModel.likes?.length ?? 0}',
                  style: const TextStyle(color: AppColors.darkBlueColor),
                ),
                10.Hspace,
                GestureDetector(
                    onTap: onDisLikeTapped,
                    child: Icon(
                      feedbackModel.dislikes!.contains(userId)
                          ? Icons.thumb_down
                          : Icons.thumb_down_alt_outlined,
                      color: AppColors.darkBlueColor,
                    )),
                4.Hspace,
                Text(
                  '${feedbackModel.dislikes?.length ?? 0}',
                  style: const TextStyle(color: AppColors.darkBlueColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
