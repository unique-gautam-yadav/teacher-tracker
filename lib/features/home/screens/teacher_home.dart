// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teacher_tracker/common/auth_preferences.dart';
import 'package:teacher_tracker/common/filled_button.dart';
import 'package:teacher_tracker/common/firestore_collections.dart';
import 'package:teacher_tracker/common/models/teacher_model.dart';
import 'package:teacher_tracker/features/auth/screens/teacher_login.dart';
import 'package:teacher_tracker/routes/routes.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  TeacherModel? teacherModel;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _block = TextEditingController();
  final TextEditingController _floor = TextEditingController();
  final TextEditingController _room = TextEditingController();

  getData() async {
    String u = FirebaseAuth.instance.currentUser!.uid;
    var d = await teachers.doc(u).get();

    teacherModel = TeacherModel.fromMap(d.data()!);
    _name.text = teacherModel!.name;
    _department.text = teacherModel!.department;
    _block.text = teacherModel!.block;
    _floor.text = teacherModel!.floor;
    _room.text = teacherModel!.roomNo;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.paddingOf(context).top + 20),
            Row(
              children: [
                const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await AuthPreferences.clear();
                    if (context.mounted) {
                      context.go(AppRoutes.onboarding.path);
                    }
                  },
                  icon: const Icon(Iconsax.logout),
                ),
              ],
            ),
            if (teacherModel == null)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            teacherModel!.imageUrl,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      titleNEditing(title: "Name", controller: _name),
                      const SizedBox(height: 15),
                      titleNEditing(
                          title: "Department", controller: _department),
                      const SizedBox(height: 15),
                      titleNEditing(title: "Block", controller: _block),
                      const SizedBox(height: 15),
                      titleNEditing(title: "Floor", controller: _floor),
                      const SizedBox(height: 15),
                      titleNEditing(title: "Room No", controller: _room),
                      const SizedBox(height: 15),
                      const Text(
                        "Subjects",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: teacherModel!.subjects.map(
                          (e) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey.withOpacity(.3),
                              ),
                              child: Text(e),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 80),
                      DynamicFilledButton(
                        child: const Text("Update"),
                        onPressed: () async {
                          await teachers
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'name': _name.text,
                            'department': _department.text,
                            'block': _block.text,
                            'floor': _floor.text,
                            'roomNo': _room.text,
                            'subjects': teacherModel!.subjects,
                          });
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.paddingOf(context).bottom + 50),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Column titleNEditing(
      {required String title, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          decoration: inputDecoration(hintText: title),
        ),
      ],
    );
  }
}
