import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_tracker/common/app_images.dart';
import 'package:teacher_tracker/common/filled_button.dart';
import 'package:teacher_tracker/routes/routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.paddingOf(context).top + 20),
                  const Text(
                    "Welcome,",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const Text("Select your user type and login"),
                  const Spacer(),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: SvgPicture.asset(
                      AppImages.rideSvg,
                      height: 200,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            DynamicFilledButton(
              onPressed: () {
                context.push(AppRoutes.teacherLogin.path);
              },
              child: const Text("Teacher Login"),
            ),
            const SizedBox(height: 10),
            DynamicFilledButton(
              onPressed: () {
                context.push(AppRoutes.studentLogin.path);
              },
              child: const Text("Student Login"),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 20),
          ],
        ),
      ),
    );
  }
}
