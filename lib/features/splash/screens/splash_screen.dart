import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_tracker/common/auth_preferences.dart';
import 'package:teacher_tracker/common/firestore_collections.dart';
import 'package:teacher_tracker/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> func() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      if (FirebaseAuth.instance.currentUser != null) {
        bool? isTeacher = await AuthPreferences.getTeacher();
        if (isTeacher ?? false) {
          var d =
              await teachers.doc(FirebaseAuth.instance.currentUser!.uid).get();
          if (mounted) {
            if (d.exists) {
              context.go(AppRoutes.teacherHome.path);
              return;
            } else {
              context.go(AppRoutes.teacherDetail.path);
            }
          }
        } else {
          if (mounted) {
            context.go(AppRoutes.studentHome.path);
          }
        }

        return;
      }

      context.go(AppRoutes.onboarding.path);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
