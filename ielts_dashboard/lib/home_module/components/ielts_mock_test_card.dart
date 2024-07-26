import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/controller/mock_test_details_controller.dart';
import 'package:ielts_dashboard/home_module/model/ielts_mock_test_model.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _mockTestDetailsController = Get.put(MockTestDetailsController());

class IeltsMockTestCard extends StatefulWidget {
  const IeltsMockTestCard({
    Key? key,
    required this.tests,
  }) : super(key: key);

  final List<Tests> tests;

  @override
  State<IeltsMockTestCard> createState() => _IeltsMockTestCardState();
}

class _IeltsMockTestCardState extends State<IeltsMockTestCard> {
  late RxList<bool> isLoadingList = RxList.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoadingList.value = List<bool>.filled(widget.tests.length, false);
  }

  Color _getColor(String status) {
    switch (status) {
      case 'complete':
        return AppColors.yellowyGreen;
      case 'pending':
        return AppColors.backgroundColor;
      case 'locked':
        return AppColors.gainsBoro;
      default:
        return Colors.transparent; // Default color
    }
  }

  Color _getBorderColor(String status) {
    switch (status) {
      case 'complete':
        return Colors.black;
      case 'pending':
        return AppColors.primaryColor.withOpacity(0.4);
      case 'locked':
        return AppColors.nobel;
      default:
        return Colors.transparent; // Default border color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.tests.length,
        (index) {
          final item = widget.tests[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 16),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getColor(item.status.toString()),
                        border: Border.all(
                          color: _getBorderColor(item.status.toString()),
                        ),
                      ),
                      child: item.status == 'complete'
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.black,
                                size: 12,
                              ),
                            )
                          : Center(
                              child: Text('${index + 1} '),
                            ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.name.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.brightGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.status == 'pending' ? "20 Questions" : "${item.band} Bands",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.paleSky.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
                if (item.status == 'pending') ...[
                  Obx(
                    () => GestureDetector(
                      onTap: () async {
                        isLoadingList[index] = true;
                        await _mockTestDetailsController.mockTestDetails(testId: item.testId);
                        Future.delayed(
                          Duration.zero,
                          () => context.pushNamed(IeltsGoPaths.ieltsExercise),
                        );
                        isLoadingList[index] = false;
                      },
                      child: isLoadingList[index] == true
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            )
                          : SvgPicture.asset(IeltsAssetPath.startMockTest),
                    ),
                  ),
                ],
                if (item.status == 'complete') ...[
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(IeltsAssetPath.playMockTest),
                  ),
                ],
                if (item.status == 'locked') ...[
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(IeltsAssetPath.lockMockTest),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
