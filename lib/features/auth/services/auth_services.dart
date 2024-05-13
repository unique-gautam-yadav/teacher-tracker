import 'package:flutter/material.dart';
import 'package:teacher_tracker/common/models/teacher_model.dart';

class AuthServices extends ChangeNotifier {
  TeacherModel? _teacherModel;

  set teacherModel(TeacherModel t) {
    _teacherModel = t;
    notifyListeners();
  }

  TeacherModel? getTeacher() {
    return _teacherModel;
  }
}
