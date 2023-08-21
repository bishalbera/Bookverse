// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final String booksRead;
  final String verseCoins;
  final String password;
  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.booksRead,
    required this.verseCoins,
    required this.password,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    String? booksRead,
    String? verseCoins,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      booksRead: booksRead ?? this.booksRead,
      verseCoins: verseCoins ?? this.verseCoins,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
      'booksRead': booksRead,
      'verseCoins': verseCoins,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      booksRead: map['booksRead'] as String,
      verseCoins: map['verseCoins'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, uid: $uid, booksRead: $booksRead, verseCoins: $verseCoins, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.uid == uid &&
        other.booksRead == booksRead &&
        other.verseCoins == verseCoins &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        booksRead.hashCode ^
        verseCoins.hashCode ^
        password.hashCode;
  }
}
