import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_verse/common/constants/constants.dart';
import 'package:book_verse/features/database/models/room.dart';
import 'package:book_verse/utils/show_snackBar.dart';
import 'package:flutter/material.dart';

class DataBaseRepository {
  /// here, I'm making some functions but honestly, I'm super tired

  void createRoomInFirebase(BuildContext context, RoomModel model) {
    firestore
        .collection('rooms')
        .doc(model.roomCode)
        .set(model.toMap())
        .then((value) {
      showSnackBar(
        context,
        "Room created!",
        "Hey there, your room's created!",
        ContentType.success,
      );
    });
  }
}
