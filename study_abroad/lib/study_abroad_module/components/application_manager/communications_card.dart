import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/controller/get_comments_controller.dart';
import 'package:study_abroad/study_abroad_module/controller/upload_comments_controller.dart';
import 'package:study_abroad/study_abroad_module/models/get_comments_model.dart';
import 'package:utilities/form_fields/custom_text_fields.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _uploadCommentController = Get.put(UploadCommentsController());
final _getCommentsController = Get.put(GetCommentsController());

class CommunicationCard extends StatefulWidget {
  const CommunicationCard({super.key, required this.comments, required this.applicationId});

  final GetCommentsModel? comments;
  final String applicationId;

  @override
  State<CommunicationCard> createState() => _CommunicationCardState();
}

class _CommunicationCardState extends State<CommunicationCard> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 14),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                SvgPicture.asset(
                  StudyAbroadAssetPath.communications,
                  height: 40,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Communications",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          StudyAbroadAssetPath.online,
                          height: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Neha Dubey (Counsellor)",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.boulder),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(color: AppColors.platinum),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                (widget.comments?.result?.isEmpty == true ? 0.2 : 0.42),
            child: widget.comments?.result?.isEmpty == true
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppColors.whiteSmoke,
                      ),
                      child: Text(
                        "Start a Conversation",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.comments?.result?.length ?? 0,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final comment = widget.comments?.result?[index];
                      final isSender = comment?.type == 1;
                      final date = DateTime.parse(comment?.createdAt ?? '');
                      bool showDateChip = false;
                      if (index == 0) {
                        showDateChip = true;
                      } else {
                        final previousComment = widget.comments?.result?[index - 1];
                        final previousDate = DateTime.parse(previousComment?.createdAt ?? '');
                        showDateChip = previousDate.day != date.day ||
                            previousDate.month != date.month ||
                            previousDate.year != date.year;
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showDateChip) ...[
                            DateChip(date: date, color: AppColors.whiteSmoke),
                            const SizedBox(height: 10),
                          ],
                          const SizedBox(height: 10),
                          BubbleSpecialOne(
                            text: comment?.comment ?? "",
                            isSender: isSender,
                            color: isSender ? AppColors.primaryColor : AppColors.receiverColor,
                            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: isSender ? AppColors.white : Colors.black,
                                ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: AppBoxDecoration.getBorderBoxDecoration(
              borderColor: AppColors.platinum,
              borderRadius: 11,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: _textController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    hintText: "Your Message",
                    fillColor: Colors.transparent,
                    showBorder: false,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(60, 40),
                  ),
                  onPressed: () {
                    if (_textController.text.trim().isEmpty) {
                      return;
                    }
                    _uploadCommentController
                        .uploadComments(
                      applicationId: widget.applicationId,
                      comments: _textController.text.trim(),
                    )
                        .then((value) {
                      if (value['status'].toString() == '200') {
                        _getCommentsController.getComments(applicationId: widget.applicationId);
                        _textController.clear();
                      }
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Send"),
                      const SizedBox(width: 4),
                      SvgPicture.asset(StudyAbroadAssetPath.send)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
