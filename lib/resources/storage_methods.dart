import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/provider/image_upload_provider.dart';
import 'package:skype_clone/resources/chat_methods.dart';

class StorageMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference _storageReference;
  UserModel userModel = UserModel();

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      UploadTask storageUploadTask = _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask).ref.getDownloadURL();
      // print(url);
      return url.toString();
    } catch (e) {
      return null;
    }
  }
  void uploadImage(
      {File image,
      String receiverId,
      String senderId,
      ImageUploadProvider imageUploadProvider}) async {
    final ChatMethods chatMethods = ChatMethods();
    imageUploadProvider.setToLoading();
    String url = await uploadImageToStorage(image);
    imageUploadProvider.setToIdle();
    chatMethods.setImageMsg(url, receiverId, senderId);
  }
}
