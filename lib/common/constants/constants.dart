import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? currentUserName = FirebaseAuth.instance.currentUser?.displayName;
String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

const appName = "TheBookVerse";
const appTagLine = "Connecting Readers, One Verse at a Time";

String userName = "";

int selectedIndex = 0;

// firebase constants

var firestore = FirebaseFirestore.instance;

var firebaseAuth = FirebaseAuth.instance;
