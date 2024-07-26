import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_functions.dart';
import 'package:study_abroad/study_abroad_module/models/filter_data_model.dart';


class FilterListRadioPage extends StatefulWidget {
  final Filters? filter;
  final RxMap<String, List<String>> tempFilter;
  const FilterListRadioPage({
    Key? key,
    this.filter,
    required this.tempFilter,
  }) : super(key: key);

  @override
  State<FilterListRadioPage> createState() => _FilterListRadioPageState();
}

class _FilterListRadioPageState extends State<FilterListRadioPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final options = widget.filter?.options?[index];
        return ListTile(
          onTap: () {
            onTapOneSelection(
              filterMap: widget.tempFilter,
              options: widget.filter?.options,
              filterKey: widget.filter?.filterKey,
              optionValue: options?.value,
            );
            setState(() {});
            debugPrint("${widget.tempFilter}");
          },
          leading: Radio(
            value: checkContains(
              filterKey: widget.filter?.filterKey,
              optionValue: options?.value,
              filterMap: widget.tempFilter,
            ),
            groupValue: true,
            onChanged: (value) {
              onTapOneSelection(
                filterMap: widget.tempFilter,
                options: widget.filter?.options,
                filterKey: widget.filter?.filterKey,
                optionValue: options?.value,
              );
              setState(() {});
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
