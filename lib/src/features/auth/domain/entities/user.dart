import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/utils/typedefs.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
  });

  final String uid;
  final String email;
  final String fullName;


  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
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
        );

  LocalUser copyWith({
    String? uid,
    String? email,
    String? fullName,
  }) {
    return LocalUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
    };
  }
}
