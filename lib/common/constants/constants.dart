import 'package:firebase_auth/firebase_auth.dart';

String? currentUserName = FirebaseAuth.instance.currentUser?.displayName;
String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;
