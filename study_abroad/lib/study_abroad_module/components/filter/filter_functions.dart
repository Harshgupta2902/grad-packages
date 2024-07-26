import 'package:study_abroad/study_abroad_module/models/filter_data_model.dart';

bool onTap({
  required String? filterKey,
  required String? optionValue,
  required Map<String, List<String>> filterMap,
  List<Options>? options,
}) {
  if (filterMap.containsKey(filterKey) && filterMap[filterKey]!.contains((optionValue))) {
    filterMap[filterKey]!.removeWhere((value) => value == optionValue);
  } else {
    filterMap.putIfAbsent(filterKey ?? "-", () => []).add(optionValue ?? "");
  }

  return filterMap.containsKey(filterKey) && filterMap[filterKey]!.contains(optionValue);
}

bool onTapOneSelection({
  required String? filterKey,
  required String? optionValue,
  required Map<String, List<String>> filterMap,
  List<Options>? options,
}) {
  filterMap[filterKey ?? ""] = [optionValue ?? ""];

  return filterMap.containsKey(filterKey) && filterMap[filterKey]!.contains(optionValue);
}

bool checkContains({
  required String? filterKey,
  required String? optionValue,
  required Map<String, List<String>> filterMap,
}) {

  return filterMap.containsKey(filterKey) && filterMap[filterKey]!.contains(optionValue);
}
