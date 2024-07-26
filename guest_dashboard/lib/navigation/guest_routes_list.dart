import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:guest_dashboard/test_module/view/guest_buy_plans.dart';
import 'package:guest_dashboard/test_module/view/guest_pre_test_screen.dart';
import 'package:guest_dashboard/test_module/view/guest_result_screen.dart';
import 'package:guest_dashboard/test_module/view/guest_test_web_view.dart';
import 'package:guest_dashboard/test_module/view/view_youtube_video.dart';

List<RouteBase> guestRoutes({
  required GlobalKey<NavigatorState>? shellNavigatorKey,
  required GlobalKey<NavigatorState>? rootNavigatorKey,
}) {
  return [

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GuestGoPaths.youtubeVideoView,
      name: GuestGoPaths.youtubeVideoView,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final url = extras['url'];
        return ViewYoutubeVideo(
          url: url,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GuestGoPaths.guestPreTestScreen,
      name: GuestGoPaths.guestPreTestScreen,
      builder: (context, state) {
        return const GuestPreTestScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GuestGoPaths.guestTestWebView,
      name: GuestGoPaths.guestTestWebView,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final url = extras['url'];
        final successUrl = extras['successUrl'];
        return GuestTestWebView(
          url: url,
          successUrl: successUrl,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: GuestGoPaths.guestResultScreen,
      path: GuestGoPaths.guestResultScreen,
      builder: (context, state) {
        return const GuestResultScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: GuestGoPaths.guestBuyPlans,
      path: GuestGoPaths.guestBuyPlans,
      builder: (context, state) {
        return const GuestBuyPlans();
      },
    ),
  ];
}
