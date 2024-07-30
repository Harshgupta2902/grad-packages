import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

typedef SelectExamCallBack = void Function(String?);
typedef SelectExamCatCallBack = void Function(String?);

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: SimpleDialog(
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(cornerRadius: 10),
              ),
              backgroundColor: AppColors.backgroundColor,
              children: <Widget>[
                Center(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Processing Payment....",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Please Wait....",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future<void> errorDialog(BuildContext context, {String? title}) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
          ),
          backgroundColor: AppColors.backgroundColor,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Lottie.asset("packages/utilities/assets/error.json", height: 120, width: 120),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title ?? "Something Went Wrong!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  static Future<void> exitFromTest(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
          ),
          backgroundColor: AppColors.backgroundColor,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Lottie.asset("packages/utilities/assets/error.json", height: 120, width: 120),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Do you want to Cancel the Test",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.pop();
                          context.pop();
                        },
                        child: const Text("Exit"),
                      ),
                      ElevatedButton(
                        onPressed:() => context.pop(),
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  static Future<void> successDialog(BuildContext context, {String? title}) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
          ),
          backgroundColor: AppColors.backgroundColor,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Lottie.asset("packages/utilities/assets/success_session.json",
                      height: 120, width: 120),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title ?? "Successful",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  static Future<void> cancelledDialog(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
          ),
          backgroundColor: AppColors.backgroundColor,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Lottie.asset("packages/utilities/assets/cancel.json", height: 120, width: 120),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Payment Cancelled....",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        );
      },
    );

    await Future.delayed(const Duration(seconds: 3));
    Future.delayed(
      Duration.zero,
      () => Navigator.pop(context),
    );
  }

  static Future<void> webViewErrorDialog(BuildContext context,
      {String? title, bool? showButton}) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
          ),
          backgroundColor: AppColors.backgroundColor,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Lottie.asset("packages/utilities/assets/error.json", height: 120, width: 120),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title ?? "Something went wrong!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                  ),
                  if (showButton == true) ...[
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Try Again"),
                    ),
                  ],
                ],
              ),
            )
          ],
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    Future.delayed(
      Duration.zero,
      () => Navigator.pop(context),
    );
  }

  static Future<void> selectTestPrepDialog(BuildContext context,
      {required List data, required SelectExamCallBack examCallBack}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 16),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(),
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Select Exam",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Please Select the exam from the options given below",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 60,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.pop();
                          examCallBack(data[index]);
                        },
                        child: Container(
                          decoration: AppBoxDecoration.getBoxDecoration(
                            color: Colors.transparent,
                            showShadow: true,
                            offsetX: 0,
                            offsetY: 20,
                            spreadRadius: 0,
                            blurRadius: 40,
                            shadowColor: Colors.black,
                          ),
                          child: Image.asset(
                            data[index],
                            height: 60,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> selectTestCatDialog(BuildContext context,
      {required List data, required SelectExamCatCallBack examCatCallBack}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 16),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(),
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Select Exam Category",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Please Select the exam category from the options given below",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(data.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        context.pop();
                        examCatCallBack(data[index]);
                      },
                      child: Container(
                        decoration: AppBoxDecoration.getBorderBoxDecoration(
                            color: AppColors.softPeach,
                            borderColor: AppColors.boulder.withOpacity(0.5),
                            showShadow: true,
                            borderRadius: 8),
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            data[index],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
