import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/constants/strings.dart';
import 'package:skype_clone/models/call.dart';

class CallMethods {
  Stream<DocumentSnapshot> callStream({String uid}) =>
      FirebaseFirestore.instance
          .collection(CALL_COLLECTION)
          .doc(uid)
          .snapshots();

  Future<bool> makeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await FirebaseFirestore.instance
          .collection(CALL_COLLECTION)
          .doc(call.callerId)
          .set(hasDialledMap);
      await FirebaseFirestore.instance
          .collection(CALL_COLLECTION)
          .doc(call.receiverId)
          .set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({Call call}) async {
    try {
      await FirebaseFirestore.instance
          .collection(CALL_COLLECTION)
          .doc(call.callerId)
          .delete();
      await FirebaseFirestore.instance
          .collection(CALL_COLLECTION)
          .doc(call.receiverId)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
