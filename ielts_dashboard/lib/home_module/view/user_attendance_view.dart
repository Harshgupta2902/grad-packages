import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/controller/user_attendance_controller.dart';
import 'package:intl/intl.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/theme/app_colors.dart';

final _userAttendanceController = Get.put(UserAttendanceController());

class UserAttendanceView extends StatefulWidget {
  const UserAttendanceView({Key? key}) : super(key: key);

  @override
  UserAttendanceViewState createState() => UserAttendanceViewState();
}

class UserAttendanceViewState extends State<UserAttendanceView> {
  DateTime _currentMonth = DateTime.now();
  List<DateTime> presentDates = [];
  List<DateTime> absentDates = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _userAttendanceController.getUserAttendance();
      List<DateTime> fetchedPresentDates = [];
      List<DateTime> fetchedAbsentDates = [];
      _userAttendanceController.state?.result?.forEach((attendance) {
        DateTime date = DateFormat('dd-MM-yyyy').parse(attendance.classDate ?? "");
        if (attendance.attend == 1) {
          fetchedPresentDates.add(date);
        } else {
          fetchedAbsentDates.add(date);
        }
      });
      setState(() {
        presentDates = fetchedPresentDates;
        absentDates = fetchedAbsentDates;
      });
    });
  }

  List<DateTime> getDisplayDates(DateTime currentDate) {
    final firstDateOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDateOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

    DateTime firstDisplayDate = firstDateOfMonth;
    DateTime lastDisplayDate = lastDateOfMonth;

    DateTime indexDate = firstDisplayDate;

    while (indexDate.weekday != DateTime.sunday) {
      indexDate = indexDate.subtract(const Duration(days: 1));
    }
    firstDisplayDate = indexDate;

    indexDate = lastDisplayDate;
    while (indexDate.weekday != DateTime.saturday) {
      indexDate = indexDate.add(const Duration(days: 1));
    }
    lastDisplayDate = indexDate.add(const Duration(days: 1));

    List<DateTime> dates = [];

    indexDate = firstDisplayDate;
    while (indexDate.isBefore(lastDisplayDate)) {
      dates.add(indexDate);

      indexDate = indexDate.add(const Duration(days: 1));
    }

    return dates;
  }

  String _getAttendanceStatus(
    DateTime day,
    List<DateTime> presentDates,
    List<DateTime> absentDates,
  ) {
    if (_currentMonth.month != day.month) {
      return '';
    } else if (presentDates.contains(day)) {
      return 'P';
    } else if (absentDates.contains(day)) {
      return 'A';
    } else {
      return '';
    }
  }

  _getDates(int index) {
    setState(() {
      final previousMonth = _currentMonth;
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + index);
      if (index == 0) {
        _currentMonth = DateTime.now();
        setState(() {
          _selectedIndex = index;
        });
        debugPrint("-----------| _selectedIndex : $_selectedIndex ");
        return;
      }
      if (index != 0) {
        if (_currentMonth.isAfter(previousMonth)) {
          _selectedIndex++;
        } else if (_currentMonth.isBefore(previousMonth)) {
          _selectedIndex--;
        }
      }

      debugPrint("---------- index : $index $_currentMonth  -| _selectedIndex : $_selectedIndex ");

      getDisplayDates(_currentMonth);
    });
  }

  DateTime? selectedDate;

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = getDisplayDates(_currentMonth);
    final monthName = DateFormat('MMMM yyyy').format(_currentMonth);

    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        centerTitle: true,
        showActions: false,
        title: "Attendance",
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    monthName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _getDates(-1);
                        },
                        child: SvgPicture.asset(IeltsAssetPath.prev),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          _getDates(1);
                        },
                        child: SvgPicture.asset(IeltsAssetPath.next),
                      ),
                      const SizedBox(width: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          backgroundColor: AppColors.primaryColor,
                          minimumSize: const Size(60, 36),
                        ),
                        onPressed: () {
                          _getDates(0);

                          DateTime now = DateTime.now();
                          setState(() {
                            selectedDate = DateTime(now.year, now.month, now.day);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Today",
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    letterSpacing: 0.15,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      7,
                      (index) {
                        List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                        return Flexible(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: AppColors.primaryColor.withOpacity(0.5),
                            child: Text(
                              weekdays[index],
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  _userAttendanceController.obx(
                    (state) {
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7, mainAxisExtent: 80
                            // childAspectRatio: 0.6,
                            ),
                        itemCount: daysInMonth.length,
                        itemBuilder: (context, index) {
                          DateTime now = DateTime.now();
                          final day = daysInMonth[index];
                          final today = DateFormat('yyyy-MM-dd').format(now);
                          final isToday = DateFormat('yyy-MM-dd').format(day);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = day;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                              color: isToday == today
                                  ? AppColors.primaryColor.withOpacity(0.2)
                                  : day.month != _currentMonth.month
                                      ? Colors.white
                                      : selectedDate != null &&
                                              day.day == selectedDate!.day &&
                                              day.month == selectedDate!.month &&
                                              day.year == selectedDate!.year
                                          ? AppColors.primaryColor.withOpacity(0.5)
                                          : Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: _getAttendanceStatus(day, presentDates, absentDates) ==
                                              'P'
                                          ? AppColors.primaryColor
                                          : _getAttendanceStatus(day, presentDates, absentDates) ==
                                                  'A'
                                              ? Colors.red
                                              : day.month != _currentMonth.month
                                                  ? Colors.grey
                                                  : day.weekday ==
                                                          DateTime.sunday // Check if day is Sunday
                                                      ? Colors.red // Apply red color for Sunday
                                                      : Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (_getAttendanceStatus(day, presentDates, absentDates) ==
                                      'P') ...[
                                    Text(
                                      'P',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                  if (_getAttendanceStatus(day, presentDates, absentDates) ==
                                      'A') ...[
                                    Text(
                                      'A',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    onError: (error) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CustomErrorOrEmpty(title: "Currently attendance not available"),
                      );
                    },
                    onEmpty: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CustomErrorOrEmpty(title: "Currently attendance not available"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: selectedDate != null && !isToday(selectedDate!)
          ? FloatingActionButton(
              shape: const CircleBorder(side: BorderSide.none),
              foregroundColor: AppColors.primaryColor,
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                _getDates(0);
                setState(() {
                  selectedDate = DateTime.now();
                });
              },
              child: Text(
                DateFormat('dd').format(DateTime.now()),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
              ))
          : null,
    );
  }
}
