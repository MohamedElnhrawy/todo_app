import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/services/injection_container.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUser> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUser.fromMap(event.data()!));
}
