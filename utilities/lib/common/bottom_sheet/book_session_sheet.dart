import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:utilities/components/button_loader.dart';
import 'package:utilities/common/controller/book_session_controller.dart';
import 'package:utilities/packages/dialogs.dart';

import 'package:utilities/form_fields/custom_dropdown_fields.dart';
import 'package:utilities/form_fields/custom_text_fields.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';

void bookSessionSheet(BuildContext context, {required String service}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    builder: (BuildContext context) {
      return BookSessionSheet(service: service);
    },
  );
}

class BookSessionSheet extends StatefulWidget {
  final String service;

  const BookSessionSheet({Key? key, required this.service}) : super(key: key);

  @override
  BookSessionSheetState createState() => BookSessionSheetState();
}

class BookSessionSheetState extends State<BookSessionSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final _bookSessionController = Get.put(BookSessionController());
  String? selectedSlot;
  @override
  void initState() {
    super.initState();
    _commentController.text = widget.service == ""
        ? "I want to book a session"
        : "I want to enroll for the ${widget.service} also and join a session";
  }

  @override
  Widget build(BuildContext context) {
    var timings = [
      "9:00 AM - 10:00 AM",
      "10:00 AM - 11:00 AM",
      "11:00 AM - 12:00 PM",
      "12:00 PM - 1:00 PM",
      "1:00 PM - 2:00 PM",
      "2:00 PM - 3:00 PM",
      "3:00 PM - 4:00 PM",
      "4:00 PM - 5:00 PM",
      "5:00 PM - 6:00 PM"
    ];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Book a Session Now",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                "Select Slot Timings from below and get one on one counselling session",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              CustomDropDownFormField(
                items: List.generate(timings.length, (index) {
                  return DropdownMenuItem(
                    value: timings[index],
                    child: Text(
                      timings[index],
                    ),
                  );
                }),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a slot timing';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedSlot = value as String?;
                  });
                },
                hintText: "Select Slot Timings",
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                controller: _commentController,
                hintText: "Enter Comments",
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter comments';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _bookSessionController
                        .bookSession(
                            slot: selectedSlot.toString(), comment: _commentController.text)
                        .then((value) {
                      if (value.toString() == "200") {
                        context.pop();
                        Dialogs.successDialog(context, title: "Session Booked");
                      }
                    });
                  }
                },
                child: ButtonLoader(
                  isLoading: _bookSessionController.isLoading,
                  buttonString: "Book Now",
                  loaderString: "",
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
