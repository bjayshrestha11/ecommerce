import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StorageReference _storageReference;

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      StorageUploadTask storageUploadTask =
          _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
      return url;
    } catch (e) {
      return null; 
    }
  }
}