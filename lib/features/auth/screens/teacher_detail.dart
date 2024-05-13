import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teacher_tracker/common/filled_button.dart';
import 'package:teacher_tracker/common/firestore_collections.dart';
import 'package:teacher_tracker/common/models/teacher_model.dart';
import 'package:teacher_tracker/common/pick_image.dart';
import 'package:teacher_tracker/features/auth/screens/teacher_login.dart';
import 'package:teacher_tracker/routes/routes.dart';

class TeacherDetailScreen extends StatefulWidget {
  const TeacherDetailScreen({super.key});

  @override
  State<TeacherDetailScreen> createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _block = TextEditingController();
  final TextEditingController _floor = TextEditingController();
  final TextEditingController _roomNo = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final ValueNotifier<List<String>> _subjectsList =
      ValueNotifier<List<String>>([]);

  File? _pickedFile;

  @override
  void initState() {
    super.initState();
    _phone.text = FirebaseAuth.instance.currentUser!.phoneNumber ?? "";
  }

  @override
  void dispose() {
    _name.dispose();
    _department.dispose();
    _subject.dispose();
    _subjectsList.dispose();
    _block.dispose();
    _floor.dispose();
    _roomNo.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.paddingOf(context).top + 20),
                    const Text(
                      "Complete Profile",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Text(
                      "Please fill out the whole form for your identity",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        sourceSelect(
                          context,
                          sendImagePick: _pickImage,
                        );
                      },
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black.withOpacity(.3),
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: _pickedFile == null
                              ? const Center(
                                  child: Icon(Iconsax.gallery_add),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(_pickedFile!),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: _name,
                      decoration: inputDecoration(hintText: "Name"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: false,
                      controller: _phone,
                      decoration: inputDecoration(hintText: "Phone"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _department,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        if (value.length < 3) {
                          return "Must have at least 3 chars";
                        }
                        return null;
                      },
                      decoration: inputDecoration(hintText: "Department"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _subject,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        if (value.length < 3) {
                          return "Must have at least 3 chars";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.characters.last == ' ') {
                          List<String> i = _subjectsList.value;
                          String c = value.split(' ').first;

                          if (!i.contains(c)) {
                            i.add(c);
                            _subjectsList.value = List.from(i);
                          }

                          _subject.clear();
                        }
                      },
                      decoration: inputDecoration(hintText: "Subjects"),
                    ),
                    const SizedBox(height: 4),
                    ValueListenableBuilder(
                      valueListenable: _subjectsList,
                      builder: (context, value, child) {
                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: value.map((e) {
                            return Material(
                              color: Colors.grey.withOpacity(.3),
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: () {
                                  List<String> i = _subjectsList.value;
                                  i.remove(e);
                                  _subjectsList.value = List.from(i);
                                },
                                splashColor: Colors.red.withOpacity(.2),
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 4),
                                      Text(e),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Iconsax.close_circle,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _block,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              if (value.length < 3) {
                                return "Must have at least 3 chars";
                              }
                              return null;
                            },
                            decoration: inputDecoration(hintText: "Block"),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: _floor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              if (value.length < 3) {
                                return "Must have at least 3 chars";
                              }
                              return null;
                            },
                            decoration: inputDecoration(hintText: "Floor"),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: _roomNo,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              if (value.length < 3) {
                                return "Must have at least 3 chars";
                              }
                              return null;
                            },
                            decoration: inputDecoration(hintText: "Room No."),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            DynamicFilledButton(
              onPressed: () async {
                if (_pickedFile == null) return;

                FirebaseStorage storage = FirebaseStorage.instance;
                String u = FirebaseAuth.instance.currentUser!.uid;

                var ref = storage.ref("profileImages").child(u);
                String imageUrl = "";

                await ref
                    .putData(_pickedFile!.readAsBytesSync())
                    .whenComplete(() async {
                  imageUrl = await ref.getDownloadURL();
                });

                TeacherModel teacher = TeacherModel(
                  name: _name.text,
                  phone: _phone.text,
                  department: _department.text,
                  subjects: _subjectsList.value,
                  block: _block.text,
                  floor: _floor.text,
                  roomNo: _roomNo.text,
                  uid: u,
                  imageUrl: imageUrl,
                );
                await teachers.doc(teacher.uid).set(teacher.toMap());

                if (context.mounted) {
                  context.go(AppRoutes.teacherHome.path);
                }
              },
              child: const Text("Save"),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 20),
          ],
        ),
      ),
    );
  }

  void _pickImage(source) async {
    var f = await ImagePicker().pickImage(source: source);
    if (f != null) {
      var im = await ImageCropper().cropImage(
        sourcePath: f.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (im != null) {
        _pickedFile = File(im.path);
        setState(() {});
      }
    }
  }
}
