import 'package:flutter/material.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/packages/intl_form_field/countries.dart';
import 'package:utilities/packages/intl_form_field/helpers.dart';
import 'package:utilities/validators/input_formatters.dart';

class PickerDialogStyle {
  final Color? backgroundColor;
  final TextStyle? countryCodeStyle;
  final TextStyle? countryNameStyle;
  final Widget? listTileDivider;
  final EdgeInsets? listTilePadding;
  final EdgeInsets? padding;
  final Color? searchFieldCursorColor;
  final InputDecoration? searchFieldInputDecoration;
  final EdgeInsets? searchFieldPadding;
  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;
  final String languageCode;

  const CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.languageCode,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries.toList()
      ..sort(
        (a, b) =>
            a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),
      );

    super.initState();
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
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xFFF9FAFC),
                hintText: "Search Country",
              ),
              inputFormatters: [TextOnlyFormatter()],
              onChanged: (value) {
                _filteredCountries = widget.countryList.stringSearch(value)
                  ..sort(
                    (a, b) => a
                        .localizedName(widget.languageCode)
                        .compareTo(b.localizedName(widget.languageCode)),
                  );
                if (mounted) setState(() {});
              },
            ),
            // const SizedBox(height: 20),
            _filteredCountries.isEmpty
                ? const CustomErrorOrEmpty(title: "No Country Found")
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: _filteredCountries.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 20,
                                      blurRadius: 20,
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  "https://raw.githubusercontent.com/Harshgupta2902/intl_phone/master/assets/flags/${_filteredCountries[index].code.toLowerCase()}.png",
                                  height: 26,
                                  width: 26,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: Text(
                                _filteredCountries[index].localizedName(widget.languageCode),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: const Color(0XFF374151),
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              trailing: Text(
                                '+${_filteredCountries[index].dialCode}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              onTap: () {
                                _selectedCountry = _filteredCountries[index];
                                widget.onCountryChanged(_selectedCountry);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
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
