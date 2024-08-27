import 'package:flutter/material.dart';
import 'package:study_abroad/study_abroad_module/models/university_details_model.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class FaqDetail extends StatefulWidget {
  const FaqDetail({super.key, this.result});

  final Result? result;

  @override
  State<FaqDetail> createState() => _FaqDetailState();
}

class _FaqDetailState extends State<FaqDetail> {
  late List<GlobalKey> expansionTileKey;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    expansionTileKey = List.generate(widget.result?.faq?.length ?? 0, (index) => GlobalKey());
  }

  openOrCloseContainer({required int index}) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
      } else {
        selectedIndex = index;
      }
    });
    final keyContext = expansionTileKey[index].currentContext;
    if (keyContext == null) {
      return;
    }
    Scrollable.ensureVisible(
      keyContext,
      duration: const Duration(milliseconds: 400),
      alignment: 0.6,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 70),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: AppBoxDecoration.getBoxDecoration(
                    showShadow: false,
                    color: AppColors.whiteSmoke,
                    borderRadius: 16,
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ListView.separated(
                    itemCount: widget.result?.faq?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final question = widget.result?.faq?[index].question;
                      final answer = widget.result?.faq?[index].answer;
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: AppBoxDecoration.getBoxDecoration(),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => openOrCloseContainer(index: index),
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  key: expansionTileKey[index],
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      question.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontWeight: FontWeight.w600),
                                    )),
                                    AnimatedRotation(
                                      turns: selectedIndex == index ? 0 : .5,
                                      duration: const Duration(milliseconds: 400),
                                      child: const Icon(
                                        Icons.keyboard_arrow_up_outlined,
                                        color: AppColors.aluminium,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Text(
                                answer.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              crossFadeState: selectedIndex == index
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 400),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 30),
        ],
      ),
    );
  }
}
