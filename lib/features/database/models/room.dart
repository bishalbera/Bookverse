// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RoomModel {
  String name;
  String roomCode;
  List<String> participants;
  String roomTheme;
  String createdByUid;
  RoomModel({
    required this.name,
    required this.roomCode,
    required this.participants,
    required this.roomTheme,
    required this.createdByUid,
  });

  RoomModel copyWith({
    String? name,
    String? roomCode,
    List<String>? participants,
    String? roomTheme,
    String? createdByUid,
  }) {
    return RoomModel(
      name: name ?? this.name,
      roomCode: roomCode ?? this.roomCode,
      participants: participants ?? this.participants,
      roomTheme: roomTheme ?? this.roomTheme,
      createdByUid: createdByUid ?? this.createdByUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'roomCode': roomCode,
      'participants': participants,
      'roomTheme': roomTheme,
      'createdByUid': createdByUid,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      name: map['name'] as String,
      roomCode: map['roomCode'] as String,
      participants: List<String>.from((map['participants'] as List<String>)),
      roomTheme: map['roomTheme'] as String,
      createdByUid: map['createdByUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomModel(name: $name, roomCode: $roomCode, participants: $participants, roomTheme: $roomTheme, createdByUid: $createdByUid)';
  }

  @override
  bool operator ==(covariant RoomModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.roomCode == roomCode &&
        listEquals(other.participants, participants) &&
        other.roomTheme == roomTheme &&
        other.createdByUid == createdByUid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        roomCode.hashCode ^
        participants.hashCode ^
        roomTheme.hashCode ^
        createdByUid.hashCode;
  }
}
