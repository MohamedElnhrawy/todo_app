import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/utils/typedefs.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
    this.lastDataSync,
  });

  final String uid;
  final String email;
  final String fullName;
  final DateTime? lastDataSync;

  DateTime? get lastDataSynced => lastDataSync;

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
    lastDataSync: null,
        );

  @override
  List<Object?> get props => [
        uid,
        email,
        fullName,
      ];

  LocalUser.fromMap(DataMap map)
      : this(
          uid: map['uid'] as String,
          fullName: map['fullName'] as String,
          email: map['email'] as String,
    lastDataSync: (map['lastDataSync'] as Timestamp).toDate(),
        );

  LocalUser copyWith({
    String? uid,
    String? email,
    String? fullName,
    DateTime? lastDataSync,
  }) {
    return LocalUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      lastDataSync: lastDataSync ?? this.lastDataSync,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'lastDataSync': lastDataSync,
    };
  }
}
