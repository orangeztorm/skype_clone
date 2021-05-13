import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/constants/strings.dart';

class CallMethods {
  final CollectionReference callCollection = FirebaseFirestore.instance
      .collection(CALL_COLLECTION);

  Future<bool> makeCall() async{

  }

}