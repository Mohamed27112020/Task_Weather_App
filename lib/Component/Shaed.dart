
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Constant.dart';

void showSnackbar(context, text, Color color) {
  var snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: AwesomeSnackbarContent(
      color: color,
      title: 'On Snap!',
      message: text,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

Widget customLoadingIndicator() {
  return SizedBox(
    width: 100,
    height: 100,
    child: Stack(
      children: [
        CircularProgressIndicator(),
        Center(child: Text('Loading...')),
      ],
    ),
  );
}

Future<String?> fetchData() async {
  String? name;
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  for (var doc in querySnapshot.docs) {
    // ignore: avoid_print
    // print(doc.get('name'));
    name = doc.get('name');
    // Print document data

  }
  return querySnapshot.docs[0].get('name');
}
