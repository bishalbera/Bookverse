import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_verse/features/auth/models/user.dart';
import 'package:book_verse/features/home/home_screen.dart';
import 'package:book_verse/utils/move_screen.dart';
import 'package:book_verse/utils/show_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/progress_dialog.dart';

class AuthRepository {
  void signUp(BuildContext context, UserModel model) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: ProgressDialog(
            message: 'Creating an account for you please wait.. '),
      ),
    );
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: model.email, password: model.password)
        .then((value) {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

      UserModel newModel = UserModel(
          name: model.name,
          uid: uid,
          email: model.email,
          password: model.password);

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(newModel.toMap())
          .then((value) {
        showSnackBar(
          context,
          "Successful!",
          "Hey, it's successful!",
          ContentType.success,
        );
        moveScreen(context, const HomeScreen(), isPushReplacement: true);
      });
    });
  }

  void logIn(BuildContext context, String email, String pass) async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(message: 'Signing You In Please Wait..'),
    );
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      showSnackBar(
        context,
        "Successful!",
        "Hey, it's successful!",
        ContentType.success,
      );
      moveScreen(context, const HomeScreen(), isPushReplacement: true);
    });
  }
}
