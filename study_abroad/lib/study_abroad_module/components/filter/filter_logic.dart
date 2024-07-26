import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_list_multiselect_page.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_list_radio_page.dart';
import 'package:study_abroad/study_abroad_module/components/filter/vertical_tab_view.dart';
import 'package:study_abroad/study_abroad_module/models/filter_data_model.dart';

class FilterLogic extends StatefulWidget {
  final List<Filters?> filterList;
  final Map<String, List<String>>? pageFilter;
  final RxMap<String, List<String>> tempFilter;
  final Function onApply;
  const FilterLogic({
    Key? key,
    required this.filterList,
    required this.onApply,
    required this.pageFilter,
    required this.tempFilter,
  }) : super(key: key);

  @override
  State<FilterLogic> createState() => _FilterLogicState();
}

class _FilterLogicState extends State<FilterLogic> {
  @override
  void initState() {
    widget.tempFilter.value = widget.pageFilter ?? {};
    super.initState();
    debugPrint('${widget.pageFilter}');
  }

  void clearOnTap() {
    setState(() {
      widget.tempFilter.clear();
      widget.pageFilter?.clear();
      widget.onApply();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> filterListPages = [];
    List<String> filterListHeading = [];

    for (int i = 0; i < widget.filterList.length; i++) {
      filterListHeading.add(widget.filterList[i]?.filterName ?? "");
      if (widget.filterList[i]?.type == 'radio') {
        FilterListRadioPage filterListPage = FilterListRadioPage(
          filter: widget.filterList[i],
          tempFilter: widget.tempFilter,
        );
        filterListPages.add(filterListPage);
      } else {
        FilterListMultiSelectPage filterListPage = FilterListMultiSelectPage(
          filter: widget.filterList[i],
          tempFilter: widget.tempFilter,
        );
        filterListPages.add(filterListPage);
      }
    }

    return VerticalTab(
      filterCategory: filterListHeading,
      filterList: widget.filterList,
      tempFilter: widget.tempFilter,
      content: filterListPages,
      applyOnTap: () {
        widget.onApply();
        context.pop();
      },
      cancelOnTap: () {
        context.pop();
      },
      clearOnTap: clearOnTap,
    );
  }
}

Map<String, dynamic> convertMapToDesiredFormat(
  Map<String, dynamic> inputMap,
  String limit,
  String offset,
) {
  Map<String, dynamic> outputMap = {};

  inputMap.forEach((key, value) {
    List<String> data = [];
    for (var exam in value) {
      if (exam != null) {
        data.add('$exam');
      }
    }
    outputMap[key] = data.join(',');
  });

  outputMap['offset'] = offset;
  outputMap['limit'] = limit;
  debugPrint(outputMap.toString());

  return outputMap;
}
