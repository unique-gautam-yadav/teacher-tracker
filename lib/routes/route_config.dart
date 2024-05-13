import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_tracker/common/models/teacher_model.dart';
import 'package:teacher_tracker/features/auth/screens/student_login.dart';
import 'package:teacher_tracker/features/auth/screens/teacher_detail.dart';
import 'package:teacher_tracker/features/auth/screens/teacher_login.dart';
import 'package:teacher_tracker/features/home/screens/student_home.dart';
import 'package:teacher_tracker/features/home/screens/teacher_detail.dart';
import 'package:teacher_tracker/features/home/screens/teacher_home.dart';
import 'package:teacher_tracker/features/onboarding/screens/onboarding_screen.dart';
import 'package:teacher_tracker/features/splash/screens/splash_screen.dart';
import 'package:teacher_tracker/routes/routes.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splash.path,
  routes: [
    GoRoute(
      path: AppRoutes.splash.path,
      name: AppRoutes.splash.name,
      pageBuilder: (context, state) {
        return const CupertinoPage(
          child: SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.studentLogin.path,
      name: AppRoutes.studentLogin.name,
      pageBuilder: (context, state) {
        return const CupertinoPage(
          child: StudentLogin(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.teacherLogin.path,
      name: AppRoutes.teacherLogin.name,
      pageBuilder: (context, state) {
        return const CupertinoPage(
          child: TeacherLogin(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.studentHome.path,
      name: AppRoutes.studentHome.name,
      pageBuilder: (context, state) {
        return const CupertinoPage(
          child: StudentHome(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.teacherHome.path,
      name: AppRoutes.teacherHome.name,
      pageBuilder: (context, state) {
        return const CupertinoPage(
          child: TeacherHome(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.onboarding.path,
      name: AppRoutes.onboarding.name,
      pageBuilder: (context, state) {
        return const CupertinoPage(
          child: OnboardingScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.teacherDetail.path,
      name: AppRoutes.teacherDetail.name,
      pageBuilder: (context, state) {
        return const CupertinoPage(
          child: TeacherDetailScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.teacher.path,
      name: AppRoutes.teacher.name,
      pageBuilder: (context, state) {
        return CupertinoPage(
          child: TeacherScreen(
            teacher: state.extra as TeacherModel,
          ),
        );
      },
    ),
  ],
);
