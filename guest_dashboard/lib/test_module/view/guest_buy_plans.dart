import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:guest_dashboard/test_module/controller/buy_plans_controller.dart';
import 'package:guest_dashboard/test_module/controller/get_order_id_controller.dart';
import 'package:guest_dashboard/test_module/model/buy_plans_model.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/button_loader.dart';
import 'package:utilities/packages/razorpay.dart';
import 'package:utilities/theme/app_box_decoration.dart';

import 'package:utilities/theme/app_colors.dart';

final buyPlansController = Get.put(BuyPlansController());
final _getOrderIdController = Get.put(GetOrderIdController());

class GuestBuyPlans extends StatefulWidget {
  const GuestBuyPlans({super.key});

  @override
  State<GuestBuyPlans> createState() => _GuestBuyPlansState();
}

class _GuestBuyPlansState extends State<GuestBuyPlans> {
  final controller = CarouselController();
  int activeIndex = 1;

  @override
  void initState() {
    super.initState();
    buyPlansController.getPlansData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: buyPlansController.obx(
        (state) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTabBar(
                    tabList: ["Classes", "Mock Test"],
                    isScrollable: false,
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          CarouselSlider.builder(
                            carouselController: controller,
                            itemCount: state?.result?.classes?.length ?? 0,
                            itemBuilder: (context, index, realIndex) {
                              return buildClassContainer(
                                index,
                                planData: state?.result?.classes?[index],
                              );
                            },
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.6,
                              autoPlay: false,
                              enableInfiniteScroll: true,
                              disableCenter: true,
                              pauseAutoPlayOnTouch: false,
                              clipBehavior: Clip.none,
                              viewportFraction: 0.85,
                              enlargeCenterPage: true,
                              initialPage: activeIndex,
                              padEnds: true,
                              onPageChanged: (index, reason) => setState(() => activeIndex = index),
                              pageSnapping: true,
                              scrollDirection: Axis.horizontal,
                              scrollPhysics: const BouncingScrollPhysics(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildIndicator(state?.result?.classes?.length),
                        ],
                      ),
                      Column(
                        children: [
                          CarouselSlider.builder(
                            carouselController: controller,
                            itemCount: state?.result?.mockTestPlans?.length ?? 0,
                            itemBuilder: (context, index, realIndex) {
                              return buildMockTestPlanContainer(
                                index,
                                planData: state?.result?.mockTestPlans?[index],
                              );
                            },
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.65,
                              autoPlay: false,
                              enableInfiniteScroll: true,
                              disableCenter: true,
                              pauseAutoPlayOnTouch: false,
                              clipBehavior: Clip.none,
                              viewportFraction: 0.85,
                              enlargeCenterPage: true,
                              initialPage: activeIndex,
                              padEnds: true,
                              onPageChanged: (index, reason) => setState(() => activeIndex = index),
                              pageSnapping: true,
                              scrollDirection: Axis.horizontal,
                              scrollPhysics: const BouncingScrollPhysics(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildIndicator(state?.result?.mockTestPlans?.length),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        onError: (error) => GestureDetector(
          onTap: () => buyPlansController.getPlansData(),
          child: Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Something Went Wrong!",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Try Again!",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Icon(
                        Icons.replay,
                        size: 22,
                        color: AppColors.primaryColor,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int? length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length ?? 0,
        (index) {
          return Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == activeIndex
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(
                      0.5,
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildClassContainer(int index, {required Classes? planData}) {
    return Stack(
      children: [
        Container(
          decoration: planData?.recommended == 1
              ? AppBoxDecoration.getBorderBoxDecoration(
                  showShadow: true,
                  borderRadius: 22,
                  borderColor: AppColors.primaryColor,
                  shadowColor: AppColors.primaryColor,
                  offsetX: 0,
                  offsetY: 0,
                  spreadRadius: 0,
                  blurRadius: 14,
                )
              : AppBoxDecoration.getBoxDecoration(
                  showShadow: true,
                  borderRadius: 22,
                ),
          // height: MediaQuery.of(context).size.height * 0.6,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  planData?.name ?? "-",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.marineBlue,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: AppBoxDecoration.getBoxDecoration(
                    color: AppColors.fernGreen.withOpacity(.1), borderRadius: 26),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text(
                  "${planData?.discount ?? "-"} OFF",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.fernGreen,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "₹${planData?.offerPrice ?? "-"}/-",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "₹${planData?.price ?? "-"}/-",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.cadetGrey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.cadetGrey,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...List.generate(planData?.features?.length ?? 0, (index) {
                final features = planData?.features?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withOpacity(0.13),
                        ),
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          Icons.check,
                          color: AppColors.primaryColor,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "${features?.customValue ?? "-"} ${features?.keyName ?? "-"}",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    await _getOrderIdController.getOrderId(code: planData?.code ?? "");
                    final data = _getOrderIdController.state?.result;
                    if (data?.orderId != null) {
                      Future.delayed(
                        Duration.zero,
                        () => openRazorpay(
                          onTap: () {
                            debugPrint(
                                "Payment Success from guestBuyPlans and here is the on Tap:");
                            context.goNamed(GuestGoPaths.guestDashboard);
                          },
                          amount: planData?.offerPrice ?? 0,
                          title: "Buy Ielts Plans",
                          orderId: data?.orderId?.toString() ?? "",
                          context: context,
                          // currency: "USD",
                          prefill: {
                            'contact': '${data?.phone}',
                            'email': '${data?.email}',
                          },
                          description: planData?.name ?? "",
                        ),
                      );
                    }
                  },
                  child: ButtonLoader(
                    isLoading: _getOrderIdController.isLoading,
                    loaderString: "",
                    buttonString: "Buy Now",
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (planData?.recommended == 1)
          Positioned(
            left: 60,
            right: 60,
            child: Container(
              decoration: AppBoxDecoration.getBoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: 6,
              ),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Text(
                "Recommended",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildMockTestPlanContainer(int index, {required MockTestPlans? planData}) {
    return Stack(
      children: [
        Container(
          decoration: planData?.recommended == 1
              ? AppBoxDecoration.getBorderBoxDecoration(
                  showShadow: true,
                  borderRadius: 22,
                  borderColor: AppColors.primaryColor,
                  shadowColor: AppColors.primaryColor,
                  offsetX: 0,
                  offsetY: 0,
                  spreadRadius: 0,
                  blurRadius: 14,
                )
              : AppBoxDecoration.getBoxDecoration(
                  showShadow: true,
                  borderRadius: 22,
                ),
          // height: MediaQuery.of(context).size.height * 0.6,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  planData?.name ?? "-",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.marineBlue,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: AppBoxDecoration.getBoxDecoration(
                    color: AppColors.fernGreen.withOpacity(.1), borderRadius: 26),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text(
                  "${planData?.discount} OFF",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.fernGreen,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "₹${planData?.offerPrice ?? "-"}/-",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "₹${planData?.price ?? "-"}/-",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.cadetGrey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.cadetGrey,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...List.generate(planData?.features?.length ?? 0, (index) {
                final features = planData?.features?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withOpacity(0.13),
                        ),
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          Icons.check,
                          color: AppColors.primaryColor,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "${features?.customValue ?? "-"} ${features?.keyName ?? "-"}",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    await _getOrderIdController.getOrderId(code: planData?.code ?? "");
                    final data = _getOrderIdController.state?.result;

                    if (data?.orderId != null) {
                      Future.delayed(
                        Duration.zero,
                        () => openRazorpay(
                          onTap: () {
                            debugPrint(
                                "Payment Success from guestBuyPlans and here is the on Tap:");
                            context.goNamed(GuestGoPaths.guestDashboard);
                          },
                          amount: planData?.offerPrice ?? 0,
                          title: "Buy Mock Tests Plans",
                          orderId: data?.orderId?.toString() ?? "",
                          context: context,
                          // currency: "USD",
                          prefill: {
                            'contact': '${data?.phone}',
                            'email': '${data?.email}',
                          },
                          description: planData?.name ?? "",
                        ),
                      );
                    }
                  },
                  child: ButtonLoader(
                    isLoading: _getOrderIdController.isLoading,
                    loaderString: "",
                    buttonString: "Buy Now",
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (planData?.recommended == 1)
          Positioned(
            left: 60,
            right: 60,
            child: Container(
              decoration: AppBoxDecoration.getBoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: 6,
              ),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Text(
                "Recommended",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
