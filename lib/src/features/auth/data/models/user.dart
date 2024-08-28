import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';

class UserModel extends LocalUser {
  const UserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    super.lastDataSync,
  });

  const UserModel.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          lastDataSync: null,
        );

  UserModel.fromMap(DataMap map)
      : super(
            uid: map['uid'] as String,
            fullName: map['fullName'] as String,
            email: map['email'] as String,
            lastDataSync: (map['lastDataSync'] as Timestamp?)?.toDate());

  @override
  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    DateTime? lastDataSync,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      lastDataSync: lastDataSync ?? this.lastDataSync,
    );
  }

  @override
  DataMap toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'lastDataSync': lastDataSync,
    };
  }
}
