import 'dart:io';
import 'package:app/utilities/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  firebase_storage.Reference _storageReference;

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      _storageReference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      firebase_storage.UploadTask storageUploadTask =
          _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask).ref.getDownloadURL();
      return url;
    } catch (e) {
      return null; 
    }
  }

  /// The user selects a file, and the task is added to the list.
  firebase_storage.UploadTask uploadFile(File file) {
    if (file == null) {
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text("No file was selected")));
      Utils.showToast("No file was selected");
      return null;
    }

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');

    return ref.putFile(file);
  }

  /// A new string is uploaded to storage.
  firebase_storage.UploadTask uploadString() {
    const String putStringText =
        'This upload has been generated using the putString method! Check the metadata too!';

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/put-string-example.txt');

    // Start upload of putString
    return ref.putString(putStringText,
        metadata: firebase_storage.SettableMetadata(
            contentLanguage: 'en',
            customMetadata: <String, String>{'example': 'putString'}));
  }

  /// Handles the user pressing the PopupMenuItem item.
  // void handleUploadType(UploadType type) async {
  //   switch (type) {
  //     case UploadType.string:
  //       setState(() {
  //         _uploadTasks = [..._uploadTasks, uploadString()];
  //       });
  //       break;
  //     case UploadType.file:
  //       File file = await FilePicker.getFile();
  //       firebase_storage.UploadTask task = uploadFile(file);
  //       if (task != null) {
  //         setState(() {
  //           _uploadTasks = [..._uploadTasks, task];
  //         });
  //       }
  //       break;
  //     case UploadType.clear:
  //       setState(() {
  //         _uploadTasks = [];
  //       });
  //       break;
  //   }
  // }

  // _removeTaskAtIndex(int index) {
  //   setState(() {
  //     _uploadTasks = _uploadTasks..removeAt(index);
  //   });
  // }

  Future<void> downloadFile(firebase_storage.Reference ref) async {
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/temp-${ref.name}');
    if (tempFile.existsSync()) await tempFile.delete();

    await ref.writeToFile(tempFile);

    // Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text(
    //   'Success!\n Downloaded ${ref.name} \n from bucket: ${ref.bucket}\n '
    //   'at path: ${ref.fullPath} \n'
    //   'Wrote "${ref.fullPath}" to tmp-${ref.name}.txt',
    // )));
    Utils.showToast("Success!\n Downloaded ${ref.name}");
  }

}