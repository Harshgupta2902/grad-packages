import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/filter_data_model.dart';
import 'package:utilities/theme/app_colors.dart';

PageController controller = PageController(viewportFraction: 1, keepPage: true);

class VerticalTab extends StatefulWidget {
  final List<Filters?> filterList;
  final List<String> filterCategory;
  final List<Widget> content;
  final Function applyOnTap;
  final Function cancelOnTap;
  final Function clearOnTap;
  final RxMap<String, List<String>> tempFilter;
  const VerticalTab(
      {super.key,
      required this.filterList,
      required this.content,
      required this.applyOnTap,
      required this.cancelOnTap,
      required this.filterCategory,
      required this.clearOnTap,
      required this.tempFilter});

  @override
  State<VerticalTab> createState() => _VerticalTabState();
}

class _VerticalTabState extends State<VerticalTab> {
  int selectedIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
            ),
            child: ListView.separated(
              itemCount: widget.filterCategory.length,
              itemBuilder: (context, index) {
                final categoryName = widget.filterCategory[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      _pageController.jumpToPage(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          height: selectedIndex == index ? 50 : 0,
                          width: 4,
                          color: AppColors.primaryColor,
                        ),
                        Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            alignment: Alignment.center,
                            height: 50,
                            color: (selectedIndex == index)
                                ? Colors.blueGrey.withOpacity(0.2)
                                : Colors.transparent,
                            child: Text(categoryName),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox.shrink();
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              pageSnapping: true,
              onPageChanged: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              physics: const BouncingScrollPhysics(),
              itemCount: widget.content.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return widget.content[index];
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  widget.cancelOnTap();
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.primaryColor),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  widget.applyOnTap();
                },
                child: Text(
                  'Apply',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
