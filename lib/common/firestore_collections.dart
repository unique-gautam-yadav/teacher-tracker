import 'package:cloud_firestore/cloud_firestore.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _store = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> teachers =
    _store.collection('teachers');

CollectionReference<Map<String, dynamic>> users = _store.collection('users');
