import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String uid;
  final String phoneNo;

  FirestoreService({this.uid, this.phoneNo});

  final CollectionReference userDataCollectionReference =
      FirebaseFirestore.instance.collection('users');

  // get current user from DB stream
  Stream<DocumentSnapshot> get currentUserDocFromDBMappedIntoLocalUserData {
    return userDataCollectionReference.doc(uid).snapshots();
  }
}
