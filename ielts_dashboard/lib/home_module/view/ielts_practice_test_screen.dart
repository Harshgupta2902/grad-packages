import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts_dashboard/home_module/components/ielts_add_application.dart';
import 'package:ielts_dashboard/home_module/components/ielts_practice_test_card.dart';
import 'package:ielts_dashboard/home_module/controller/assigned_practice_test_controller.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/components/gradding_app_bar.dart';

final _ieltsPracticeTestController = Get.put(AssignedPractiseTestController());

class IeltsPracticeTestScreen extends StatefulWidget {
  const IeltsPracticeTestScreen({super.key});

  @override
  State<IeltsPracticeTestScreen> createState() => _IeltsPracticeTestScreenState();
}

class _IeltsPracticeTestScreenState extends State<IeltsPracticeTestScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _ieltsPracticeTestController.getPracticeTests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: _ieltsPracticeTestController.obx(
        (state) {
          return state?.result?.tests?.isEmpty == true
              ? const Center(
                  child: CustomErrorOrEmpty(
                    title: "No Practice tests available right now",
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      IeltsAddApplication(
                        completedTasks: state?.result?.card?.complete ?? 0,
                        totalTasks: state?.result?.card?.total ?? 0,
                        completionPercentage: ((state?.result?.card?.complete ?? 0) /
                            (state?.result?.card?.total ?? 0)),
                        title: state?.result?.card?.title ?? "",
                        desc: state?.result?.card?.desc ?? "",
                      ),
                      IeltsPracticeTestCard(tests: state?.result?.tests ?? []),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
