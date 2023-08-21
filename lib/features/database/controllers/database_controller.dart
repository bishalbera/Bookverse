import 'package:book_verse/features/database/models/room.dart';
import 'package:book_verse/features/database/repositories/database_repository.dart';
import 'package:flutter/material.dart';

class DataBaseController {
  // get some functions from repo and call them from here, pass args from here as well

  DataBaseRepository _repository = DataBaseRepository();

  void createRoomInFirebase(BuildContext context, RoomModel model) {
    _repository.createRoomInFirebase(context, model);
    //done
  }
}
