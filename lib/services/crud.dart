// ignore_for_file: body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    await FirebaseFirestore.instance.collection('blogs').add(blogData);
    //     .catchError((e) {
    //   log(e.code);
    // });
  }
}
