import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';

Future<void> changeCountry(
    {required List<dynamic>? data,
    required Function(String) onchange,
    Function(String)? getNewData,
    required BuildContext context,
    required String hintText}) async {
  await showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.95,
    ),
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    isScrollControlled: true,
    builder: (context) => StatefulBuilder(
      builder: (ctx, setState) => SearchDropDownSheet(
        onCountryChanged: onchange,
        data: data,
        getNewData: getNewData,
        hintText: hintText,
      ),
    ),
  );
}

class SearchDropDownSheet extends StatefulWidget {
  final List<dynamic>? data;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String>? getNewData;
  final String hintText;

  const SearchDropDownSheet({
    Key? key,
    this.data,
    required this.onCountryChanged,
    this.getNewData,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchDropDownSheet> createState() => _SearchDropDownSheetState();
}

class _SearchDropDownSheetState extends State<SearchDropDownSheet> {
  List<dynamic>? filteredData; // Add filtered data list
  String? _searchTerm;
  String? _selectedCountry;
  String? _selectedCountryValue;

  @override
  void initState() {
    super.initState();
    filteredData = widget.data;
    _searchTerm = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF9FAFC),
                hintText: widget.hintText,
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value.toLowerCase(); // Store lowercase search term
                  filteredData = widget.data
                      ?.where(
                        (answer) => answer.value!.toLowerCase().contains(_searchTerm!),
                      )
                      .toList(); // Filter data based on search term
                });
              },
            ),
            // const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: filteredData?.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(
                      "${filteredData?[index].value}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0XFF374151),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    onTap: () {
                      _selectedCountry = filteredData?[index].key.toString();
                      widget.getNewData!(_selectedCountry!);
                      _selectedCountryValue = filteredData?[index].value.toString();
                      widget.onCountryChanged(_selectedCountryValue!);
                      context.pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
