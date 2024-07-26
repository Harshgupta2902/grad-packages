import 'package:flutter/material.dart';
import 'package:utilities/theme/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabList;
  final bool isScrollable;
  final bool hasInnerShadow;
  final double height;
  final Color? selectedColor;
  final TabController? tabController;
  final double borderRadius;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Color? unselectedColor;
  final TabAlignment? tabAlignment;

  const CustomTabBar({
    Key? key,
    required this.tabList,
    this.isScrollable = false,
    this.hasInnerShadow = true,
    this.height = 50,
    this.tabController,
    this.selectedColor,
    this.borderRadius = 10,
    this.fontSize = 13,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.unselectedColor = AppColors.black,
    this.tabAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: hasInnerShadow ? Colors.transparent : AppColors.whiteSmoke,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 0.0,
                blurRadius: 0.0,
                offset: const Offset(0, 0),
              ),
              if (hasInnerShadow)
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: -2.0,
                  blurRadius: 10.0,
                ),
            ],
          ),
          child: TabBar(
            tabAlignment: tabAlignment,
            dividerColor: Colors.transparent,
            isScrollable: isScrollable,
            unselectedLabelColor: unselectedColor,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            padding: const EdgeInsets.all(6),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius - 4),
              color: selectedColor ?? AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.0,
                  blurRadius: 4.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            controller: tabController,
            tabs: tabList.map(
              (tab) {
                return Tab(
                  child: Text(
                    tab,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
