import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_dashboard/home_module/view/buy_plan_screen.dart';
import 'package:ielts_dashboard/home_module/view/ielts_mock_test_screen.dart';
import 'package:ielts_dashboard/home_module/view/ielts_practice_test_screen.dart';
import 'package:ielts_dashboard/home_module/view/ielts_schedule_screen.dart';
import 'package:ielts_dashboard/home_module/view/ielts_study_material_view.dart';
import 'package:ielts_dashboard/home_module/view/ielts_study_material_web_view.dart';
import 'package:ielts_dashboard/home_module/view/ielts_test_details_view.dart';
import 'package:ielts_dashboard/home_module/view/ielts_test_web_view.dart';
import 'package:ielts_dashboard/home_module/view/profile_screen.dart';
import 'package:ielts_dashboard/home_module/view/settings.dart';
import 'package:ielts_dashboard/home_module/view/user_attendance_view.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';

List<RouteBase> ieltsRoutes({
  required GlobalKey<NavigatorState>? shellNavigatorKey,
  required GlobalKey<NavigatorState>? rootNavigatorKey,
}) {
  return [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.webViewScreen,
      name: IeltsGoPaths.webViewScreen,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final leaveUrl = extras["leaveUrl"];
        final url = extras["url"];
        final errorLink = extras["errorLink"];
        return WebViewScreen(
          leaveUrl: leaveUrl,
          errorLink: errorLink,
          url: url,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.ieltsMockTest,
      name: IeltsGoPaths.ieltsMockTest,
      builder: (context, state) {
        return const IeltsMockTestScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.ieltsPracticeTest,
      name: IeltsGoPaths.ieltsPracticeTest,
      builder: (context, state) {
        return const IeltsPracticeTestScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.ieltsExercise,
      name: IeltsGoPaths.ieltsExercise,
      builder: (context, state) {
        return const IeltsTestDetailsView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.ieltsUserAttendance,
      name: IeltsGoPaths.ieltsUserAttendance,
      builder: (context, state) {
        return const UserAttendanceView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.ieltsSchedule,
      name: IeltsGoPaths.ieltsSchedule,
      builder: (context, state) {
        return const IeltsScheduleScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.ieltsStudyMaterialView,
      name: IeltsGoPaths.ieltsStudyMaterialView,
      builder: (context, state) {
        return const IeltsStudyMaterialView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.ieltsStudyMaterialWebView,
      name: IeltsGoPaths.ieltsStudyMaterialWebView,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final url = extras["url"];
        return IeltsStudyMaterialWebView(
          url: url,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.noPlansPurchased,
      name: IeltsGoPaths.noPlansPurchased,
      builder: (context, state) {
        return const NoPlansPurchasedScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.profile,
      name: IeltsGoPaths.profile,
      builder: (context, state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: IeltsGoPaths.setting,
      name: IeltsGoPaths.setting,
      builder: (context, state) {
        return const SettingsScreen();
      },
    ),
  ];
}
