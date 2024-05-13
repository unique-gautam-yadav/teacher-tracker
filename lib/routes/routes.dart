// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
class _APR {
  String name;
  String path;
  _APR({
    required this.name,
    required this.path,
  });
}

class AppRoutes {
  static _APR splash = _APR(name: 'splash_screen', path: '/splashScreen');
  static _APR teacherDetail = _APR(name: 'teacher_details', path: '/teacherDetails');
  static _APR teacherLogin = _APR(name: 'teacher_login', path: '/teacherLogin');
  static _APR studentLogin = _APR(name: 'student_login', path: '/studentLogin');
  static _APR teacherHome = _APR(name: 'teacher_home', path: '/teacherHome');
  static _APR studentHome = _APR(name: 'student_home', path: '/studentHome');
  static _APR onboarding = _APR(name: 'onboarding', path: '/onboarding');
  static _APR teacher = _APR(name: 'teacher', path: '/teacher');
}
