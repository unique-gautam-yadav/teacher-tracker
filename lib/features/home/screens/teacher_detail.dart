import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_tracker/common/models/teacher_model.dart';
import 'package:teacher_tracker/features/auth/screens/teacher_login.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key, required this.teacher});

  final TeacherModel teacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.green,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          teacher.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  teacher.imageUrl,
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 50),
            titleNEditing(title: "Name", value: teacher.name),
            const SizedBox(height: 15),
            titleNEditing(title: "Department", value: teacher.department),
            const SizedBox(height: 15),
            titleNEditing(title: "Block", value: teacher.block),
            const SizedBox(height: 15),
            titleNEditing(title: "Floor", value: teacher.floor),
            const SizedBox(height: 15),
            titleNEditing(title: "Room No", value: teacher.roomNo),
            const SizedBox(height: 15),
            const Text(
              "Subjects",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: teacher.subjects.map(
                (e) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(.3),
                    ),
                    child: Text(e),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 50),
          ],
        ),
      ),
    );
  }

  Column titleNEditing({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 4),
        TextFormField(
          enabled: false,
          initialValue: value,
          decoration: inputDecoration(hintText: title),
        ),
      ],
    );
  }
}
