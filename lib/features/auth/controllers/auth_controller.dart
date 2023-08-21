import 'package:book_verse/features/auth/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class AuthController {
  AuthRepository _repository = AuthRepository();

  void signUp(BuildContext context, UserModel model) {
    _repository.signUp(context, model);
  }

  void signIn(BuildContext context, String email, String pass) {
    _repository.logIn(context, email, pass);
  }
}
