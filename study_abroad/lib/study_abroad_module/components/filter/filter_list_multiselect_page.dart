import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_functions.dart';
import 'package:study_abroad/study_abroad_module/models/filter_data_model.dart';
import 'package:utilities/theme/app_colors.dart';

class FilterListMultiSelectPage extends StatefulWidget {
  final Filters? filter;
  final RxMap<String, List<String>> tempFilter;
  const FilterListMultiSelectPage({
    Key? key,
    required this.filter,
    required this.tempFilter,
  }) : super(key: key);

  @override
  State<FilterListMultiSelectPage> createState() => _FilterListMultiSelectPageState();
}

class _FilterListMultiSelectPageState extends State<FilterListMultiSelectPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final options = widget.filter?.options?[index];
        return ListTile(
          onTap: () {
            onTap(
              filterMap: widget.tempFilter,
              options: widget.filter?.options,
              filterKey: widget.filter?.filterKey,
              optionValue: options?.value,
            );
            setState(() {});
            debugPrint("${widget.tempFilter}");
          },
          leading: Checkbox(
            value: checkContains(
              filterKey: widget.filter?.filterKey,
              optionValue: options?.value,
              filterMap: widget.tempFilter,
            ),
            activeColor: AppColors.primaryColor,
            onChanged: (value) {
              debugPrint(options?.value?.toString());
              onTap(
                filterMap: widget.tempFilter,
                options: widget.filter?.options,
                filterKey: widget.filter?.filterKey,
                optionValue: options?.value,
              );
              setState(() {});

              debugPrint(widget.tempFilter.toString());
            },
          ),
          title: Text(
            options?.label.toString() ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      },
      itemCount: widget.filter?.options?.length ?? 0,
    );
  }
}
