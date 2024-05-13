import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teacher_tracker/common/auth_preferences.dart';
import 'package:teacher_tracker/common/firestore_collections.dart';
import 'package:teacher_tracker/common/models/teacher_model.dart';
import 'package:teacher_tracker/routes/routes.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final ValueNotifier<String> name = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(.3),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                name.value = value;
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: name,
                  builder: (context, value, _) {
                    var q = teachers.orderBy('name');

                    if (value.isNotEmpty) {
                      q = q.where('name',
                          isGreaterThanOrEqualTo: value,
                          isLessThan: '${value}z');
                    }

                    return FirestoreListView.separated(
                      query: q,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemBuilder: (context, doc) {
                        TeacherModel teacher = TeacherModel.fromMap(doc.data());

                        return ListTile(
                          onTap: () {
                            context.push(AppRoutes.teacher.path,
                                extra: teacher);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              teacher.imageUrl,
                            ),
                          ),
                          subtitle: Text("Dept : ${teacher.department}"),
                          title: Text(teacher.name),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
