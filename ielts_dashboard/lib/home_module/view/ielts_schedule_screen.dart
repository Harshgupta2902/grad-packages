import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/controller/class_shedule_controller.dart';
import 'package:intl/intl.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _classScheduleController = Get.put(ClassScheduleController());

class IeltsScheduleScreen extends StatefulWidget {
  const IeltsScheduleScreen({super.key});

  @override
  State<IeltsScheduleScreen> createState() => _IeltsScheduleScreenState();
}

class _IeltsScheduleScreenState extends State<IeltsScheduleScreen> {
  int? selected;
  int currentIndex = 0;

  late int year = 0;
  late String formattedMonth = "";
  late String formattedWeek = "";
  late bool _isFunctionRunning = false;

  DateTime now = DateTime.now();
  final _pageController = PageController();
  int prevData = 0;
  int nextData = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await getDateRange(currentIndex);
    });
    super.initState();
  }

  _findTodayIndex() {
    DateTime now = DateTime.now();
    List<String> dates = _classScheduleController.state?.result?.dates ?? [];
    String todayFormatted = DateFormat('yyyy-MM-dd').format(now);

    int todayDateIndex = 0;
    for (int i = 0; i < dates.length; i++) {
      if (dates[i] == todayFormatted) {
        todayDateIndex = i;
        break;
      }
    }

    _pageController.animateToPage(
      todayDateIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      selected = todayDateIndex;
    });
  }

  Future<void> getDateRange(int currentIndex) async {
    debugPrint("here is the value of Fun  _isFunctionRunning : $_isFunctionRunning");
    debugPrint("------------------- currentIndex $currentIndex");
    if (_isFunctionRunning == true) {
      debugPrint("------------XX-------------- : TRY");

      return;
    }

    try {
      _isFunctionRunning = true;
      debugPrint("here is the value of try _isFunctionRunning : $_isFunctionRunning");

      debugPrint("------------------- currentIndex $currentIndex");

      DateTime today = DateTime.now();
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

      if (currentIndex == 0) {
        startOfWeek = today;
      } else {
        startOfWeek = startOfWeek.add(Duration(days: currentIndex * 7));
      }

      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
      String startDate = DateFormat('yyyy-MM-dd').format(startOfWeek);
      String endDate = DateFormat('yyyy-MM-dd').format(endOfWeek);
      year = today.year;
      formattedMonth = DateFormat.MMM().format(today);
      formattedWeek = DateFormat.EEEE().format(today);

      debugPrint(
          "startOfWeek : $startOfWeek ------------XX----------$endOfWeek---- : $startDate --- endDate $endDate ");

      await _classScheduleController.getClassSchedule(
        start: startDate,
        end: endDate,
      );

      if (currentIndex == 0) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _findTodayIndex();
        });
      }
    } finally {
      _isFunctionRunning = false;
      debugPrint("here is the value of finally _isFunctionRunning : $_isFunctionRunning");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              children: [
                Text(
                  getCurrentDay(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.darkJungleGreen,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedWeek,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.heather,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      "$formattedMonth $year",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.heather,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      currentIndex = 0;
                    });
                    await getDateRange(0);
                  },
                  child: Container(
                    decoration: AppBoxDecoration.getBoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: 8,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Today",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    getDateRange(--currentIndex);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(IeltsAssetPath.prev),
                      const SizedBox(width: 12),
                      Text(
                        "previous",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.blueGrey,
                              fontWeight: FontWeight.w600,
                            ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    getDateRange(++currentIndex);
                  },
                  child: Row(
                    children: [
                      Text(
                        "next",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.blueGrey,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(width: 12),
                      SvgPicture.asset(IeltsAssetPath.next),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _classScheduleController.obx((state) {
            return Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: SmoothBorderRadius(cornerRadius: 32),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(state?.result?.dates?.length ?? 0, (index) {
                            final days = state?.result?.dates?[index];
                            return GestureDetector(
                              onTap: () {
                                debugPrint("selected:::::::::$selected     $index");
                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                  setState(() {
                                    selected = index;
                                  });
                                });
                              },
                              child: Container(
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  borderRadius: 10,
                                  color: selected == index ? AppColors.primaryColor : Colors.white,
                                  showShadow: false,
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.01),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      getDayOfWeek(days ?? "")[0],
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: selected == index
                                                ? Colors.white
                                                : AppColors.heather,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      days?.split("-").last ?? "-",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: selected == index
                                                ? Colors.white
                                                : AppColors.darkJungleGreen,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.vistaWhite,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      "Time",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppColors.heather,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      "Course",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppColors.heather,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.60,
                                child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (value) => setState(() {
                                    selected = value;
                                  }),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state?.result?.classData?.length ?? 0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    final item = state?.result?.classData?[index];
                                    if (item?.isEmpty == true) {
                                      return const CustomErrorOrEmpty(
                                        title: "",
                                      );
                                    }
                                    return ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: item?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final classData = item?[index];
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              getTime(classData?.startDate ?? "-"),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    color:
                                                                        AppColors.darkJungleGreen,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                            ),
                                                            Text(
                                                              classEndDate(
                                                                getTime(
                                                                    classData?.startDate ?? "-"),
                                                                classData?.classDuration ?? 0,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                    color: AppColors.heather,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Container(
                                                          height:
                                                              MediaQuery.of(context).size.height *
                                                                  0.15,
                                                          width: 2,
                                                          color: AppColors.vistaWhite,
                                                          margin: const EdgeInsets.only(right: 20),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: SizedBox(
                                                child: Container(
                                                  decoration: AppBoxDecoration.getBoxDecoration(
                                                    color: AppColors.primaryColor,
                                                    borderRadius: 16,
                                                  ),
                                                  margin: const EdgeInsets.only(bottom: 16),
                                                  padding: const EdgeInsets.all(16),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              classData?.className ?? "",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons.more_vert_rounded,
                                                            color: Colors.white,
                                                            size: 26,
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        classData?.classCode ?? "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
              onLoading: const Center(
                child: CircularProgressIndicator(color: AppColors.stormGrey),
              ))
        ],
      ),
    );
  }
}

String classEndDate(String timeString, num minutesToAdd) {
  DateTime time = DateFormat('HH:mm').parse(timeString);
  DateTime newTime = time.add(Duration(minutes: minutesToAdd.toInt()));
  String formattedTime = DateFormat('HH:mm').format(newTime);
  return formattedTime;
}

String getCurrentDay() {
  DateTime now = DateTime.now();
  int day = now.day;
  String dayString = day.toString().padLeft(2, '0');
  return dayString;
}

String getDayOfWeek(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String dayOfWeek = DateFormat('EEEE').format(date);
  return dayOfWeek;
}

String getTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String time = DateFormat('HH:mm').format(dateTime);
  return time;
}
