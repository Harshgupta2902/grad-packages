import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts_dashboard/home_module/controller/assigned_mock_test_controller.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:ielts_dashboard/home_module/components/ielts_add_application.dart';
import 'package:ielts_dashboard/home_module/components/ielts_mock_test_card.dart';
import 'package:utilities/components/gradding_app_bar.dart';

final _ieltsMockTestController = Get.put(AssignedMockTestController());

class IeltsMockTestScreen extends StatefulWidget {
  const IeltsMockTestScreen({super.key});

  @override
  State<IeltsMockTestScreen> createState() => _IeltsMockTestScreenState();
}

class _IeltsMockTestScreenState extends State<IeltsMockTestScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _ieltsMockTestController.getIeltsMockTests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: _ieltsMockTestController.obx(
        (state) {
          return state?.status == 0 || state?.result?.tests == []
              ? const Center(
                  child: CustomErrorOrEmpty(
                    title: "No Mock Tests tests available right now",
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
                      IeltsMockTestCard(
                        tests: state?.result?.tests ?? [],
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
