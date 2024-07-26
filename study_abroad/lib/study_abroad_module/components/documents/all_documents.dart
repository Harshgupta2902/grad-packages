import 'package:flutter/material.dart';
import 'package:study_abroad/study_abroad_module/components/documents/documents_card.dart';
import 'package:study_abroad/study_abroad_module/components/documents/upload_card.dart';
import 'package:study_abroad/study_abroad_module/models/get_documents_model.dart';

import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class AllDocuments extends StatefulWidget {
  const AllDocuments({super.key, this.result, this.isOther = false, this.isSingle});

  final List<Result>? result;
  final bool? isOther;
  final bool? isSingle;

  @override
  State<AllDocuments> createState() => _AllDocumentsState();
}

class _AllDocumentsState extends State<AllDocuments> {
  late List<GlobalKey> expansionTileKey;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    expansionTileKey = List.generate(widget.result?.length ?? 0, (index) => GlobalKey());
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.35),
            spreadRadius: 0.0,
            blurRadius: 0.0,
            offset: const Offset(0, 0),
          ),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: -2.0,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: widget.result?.isEmpty == true
          ? Center(
              child: Text(
              "No Document Found!",
              style: Theme.of(context).textTheme.titleSmall,
            ))
          : widget.isOther == true
              ? const UploadCard()
              : widget.result?.length == 1 && widget.isSingle == true
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.result?[0].documents?.length ?? 0,
                      padding: const EdgeInsets.all(12),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final documents = widget.result?[0].documents;
                        final doc = documents?[index].name;
                        final status = documents?[index].status;
                        final id = documents?[index].id;
                        final link = documents?[index].link;
                        return DocumentsCard(
                          doc: doc,
                          status: status,
                          docId: id.toString(),
                          downloadLink: link,
                          single: true,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    )
                  : ListView.builder(
                      itemCount: widget.result?.length ?? 0,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        final title = widget.result?[index].title;
                        final desc = widget.result?[index].description;
                        final documents = widget.result?[index].documents;
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: AppBoxDecoration.getBorderBoxDecoration(
                            borderRadius: 10,
                            color: Colors.white,
                            borderColor: selectedIndex == index
                                ? AppColors.primaryColor.withOpacity(0.3)
                                : AppColors.white,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "$title",
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                              const SizedBox(height: 6),
                                              if (desc != null)
                                                Text(
                                                  desc,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(color: AppColors.cadetGrey),
                                                  maxLines: selectedIndex == index ? null : 2,
                                                  overflow: selectedIndex == index
                                                      ? null
                                                      : TextOverflow.ellipsis,
                                                ),
                                            ],
                                          ),
                                        ),
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
                                  secondChild: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: documents?.length ?? 0,
                                    padding: const EdgeInsets.only(top: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final doc = documents?[index].name;
                                      final status = documents?[index].status;
                                      final id = documents?[index].id;
                                      final link = documents?[index].link;
                                      return DocumentsCard(
                                        doc: doc,
                                        status: status,
                                        docId: id.toString(),
                                        downloadLink: link,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 10);
                                    },
                                  ),
                                  crossFadeState: selectedIndex == index
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 400),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
