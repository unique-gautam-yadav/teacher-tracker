import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TeacherModel {
  String name;
  String phone;
  String department;
  List<String> subjects;
  String block;
  String floor;
  String roomNo;
  String uid;
  String imageUrl;
  TeacherModel({
    required this.name,
    required this.phone,
    required this.department,
    required this.subjects,
    required this.block,
    required this.floor,
    required this.roomNo,
    required this.uid,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'department': department,
      'subjects': subjects,
      'block': block,
      'floor': floor,
      'roomNo': roomNo,
      'uid': uid,
      'imageUrl' : imageUrl,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      name: map['name'] as String,
      phone: map['phone'] as String,
      department: map['department'] as String,
      subjects: List<String>.from(map['subjects'] as List<dynamic>),
      block: map['block'] as String,
      floor: map['floor'] as String,
      roomNo: map['roomNo'] as String,
      uid: map['uid'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
