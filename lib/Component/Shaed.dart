
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';


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
