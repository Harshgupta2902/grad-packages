import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_abroad/navigation/study_abroad_go_paths.dart';
import 'package:study_abroad/study_abroad_module/view/application_manager.dart';
import 'package:study_abroad/study_abroad_module/view/course_unifinder.dart';
import 'package:study_abroad/study_abroad_module/view/documents_center.dart';
import 'package:study_abroad/study_abroad_module/view/university/university_courses.dart';
import 'package:study_abroad/study_abroad_module/view/university/university_detail.dart';
import 'package:study_abroad/study_abroad_module/view/university/university_unifinder.dart';

List<RouteBase> studyAbroadRoutes({
  required GlobalKey<NavigatorState>? shellNavigatorKey,
  required GlobalKey<NavigatorState>? rootNavigatorKey,
}) {
  return [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: StudyAbroadGoPaths.documentsCenter,
      name: StudyAbroadGoPaths.documentsCenter,
      builder: (context, state) {
        return const DocumentsCenter();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: StudyAbroadGoPaths.applicationManager,
      name: StudyAbroadGoPaths.applicationManager,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final tabIndex = extras['tabIndex'];
        return ApplicationManager(tabIndex: tabIndex);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: StudyAbroadGoPaths.courseFinder,
      name: StudyAbroadGoPaths.courseFinder,
      builder: (context, state) {
        return const CourseUnifinder();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: StudyAbroadGoPaths.universityFinder,
      name: StudyAbroadGoPaths.universityFinder,
      builder: (context, state) {
        return const UniversityUnifinder();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: StudyAbroadGoPaths.universityDetails,
      name: StudyAbroadGoPaths.universityDetails,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final city = extras['city'];
        final university = extras['university'];
        return UniversityDetailsScreen(
          city: city,
          university: university,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: StudyAbroadGoPaths.universityCourses,
      name: StudyAbroadGoPaths.universityCourses,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final postData = extras['postData'];
        return UniversityCourses(
          postData: postData,
        );
      },
    ),
  ];
}
