import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';

typedef DateSelectionCallback = void Function(DateTime selectedDate);

Future<void> cupertinoCalenderDrawer(
    {required BuildContext context,
    required DateTime? initialDate,
    required DateSelectionCallback onSave,
    required String title,
    DateTime? startDate,
    DateTime? endDate,
    CupertinoDatePickerMode? mode}) async {
  DateTime? selectedDate;
  await showModalBottomSheet(
    context: context,
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Flexible(
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                mode: mode ?? CupertinoDatePickerMode.date,
                use24hFormat: true,
                minimumDate: startDate,
                maximumDate: endDate ?? DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(220, 62),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (selectedDate != null) {
                  onSave(selectedDate!);
                }

                if (selectedDate == null && initialDate != null) {
                  onSave(initialDate);
                }
                Navigator.pop(context);
              },
              child: Text(
                'Select Date',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
