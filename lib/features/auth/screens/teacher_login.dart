import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_tracker/common/auth_preferences.dart';
import 'package:teacher_tracker/common/filled_button.dart';
import 'package:teacher_tracker/common/firestore_collections.dart';
import 'package:teacher_tracker/routes/routes.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool otpEnable = false;
  late String vId;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.paddingOf(context).top + 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Teacher Login,",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const Text("Welcome sir, enter your phone below"),
                  const FractionallySizedBox(widthFactor: 1),
                  const Spacer(),
                  Center(
                    child: SvgPicture.asset(
                      'assets/svgs/camp.svg',
                      height: 200,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: !otpEnable,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _phoneController,
              onChanged: (value) {
                if (value.length > 10) {
                  _phoneController.text = value.substring(0, 10);
                }
              },
              decoration: inputDecoration(
                hintText: "Phone Number",
                prefixIcon: const SizedBox(
                  width: 10,
                  child: Center(
                    child: Text(
                      "+91",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: otpEnable,
              controller: _otpController,
              onChanged: (value) {
                if (value.length > 6) {
                  _otpController.text = value.substring(0, 6);
                }
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: inputDecoration(hintText: "OPT"),
            ),
            const SizedBox(height: 80),
            DynamicFilledButton(
              onPressed: () {
                if (!otpEnable) {
                  _sendOtp();
                } else {
                  _verifyOtp();
                }
              },
              child: Text(otpEnable ? "Verify OTP" : "Send OTP"),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 20),
          ],
        ),
      ),
    );
  }

  _verifyOtp() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: vId,
        smsCode: _otpController.text,
      );

      var u = await FirebaseAuth.instance.signInWithCredential(credential);
      await AuthPreferences.setTeacher(true);

      DocumentSnapshot<Map<String, dynamic>> d =
          await teachers.doc(u.user?.uid).get();

      if (mounted) {
        if (d.exists) {
          context.go(AppRoutes.teacherHome.path);
        } else {
          context.go(AppRoutes.teacherDetail.path);
        }
      }

      if (mounted) {
        context.go(AppRoutes.teacherHome.path);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  _sendOtp() {
    log("message");

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text}",
      verificationCompleted: (phoneAuthCredential) {
        log("Done");
      },
      verificationFailed: (error) {
        log(error.toString());
      },
      codeSent: (verificationId, forceResendingToken) {
        vId = verificationId;
        otpEnable = true;
        setState(() {});
        Fluttertoast.showToast(msg: "Code sent");
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log("time out");
      },
    );
  }
}

InputDecoration inputDecoration({
  required String hintText,
  Widget? prefixIcon,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    fillColor: Colors.grey.withOpacity(.25),
    filled: true,
    prefixIcon: prefixIcon,
    hintText: hintText,
  );
}
