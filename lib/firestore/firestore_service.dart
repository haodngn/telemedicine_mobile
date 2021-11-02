import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getHealCheckUsers(
      int healthCheckId) {
    return FirebaseFirestore.instance
        .collection("healthcheck")
        .doc(healthCheckId.toString())
        .snapshots();
  }
}
