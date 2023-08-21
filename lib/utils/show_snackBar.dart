import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackBar(
    BuildContext context, String title, String content, ContentType type) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: '$title!',
      message: '$content',
      contentType: type,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
