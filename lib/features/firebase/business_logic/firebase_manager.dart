import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseManager {
  static Future<String?> uploadImageToFirebase(File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
        storage.ref().child('images/${DateTime.now()}.png');

    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => print('Image uploaded to Firebase'));

    // Get the download URL
    String? downloadUrl = await getDownloadedImagePath(uploadTask);

    return downloadUrl;
  }

  static Future<String?> getDownloadedImagePath(UploadTask uploadImage) async {
    // Wait for the upload to complete and get the download URL
    String? downloadUrl = await uploadImage.then((TaskSnapshot snapshot) {
      return snapshot.ref.getDownloadURL();
    });

    // Print or use the download URL
    print('Download URL: $downloadUrl');
    return downloadUrl;
  }
}
  // static Future<void> uploadImageToFirebase(File image) async {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference storageReference =
  //       storage.ref().child('images/${DateTime.now()}.png');

  //   UploadTask uploadTask = storageReference.putFile(image);
  //   await uploadTask.whenComplete(() => print('Image uploaded to Firebase'));
  //   await getDownloadedImagePath(uploadTask);
  // }

  // static Future<void> getDownloadedImagePath(UploadTask uploadImage) async {
  //   // Wait for the upload to complete and get the download URL
  //   String downloadUrl = await uploadImage.then((TaskSnapshot snapshot) {
  //     return snapshot.ref.getDownloadURL();
  //   });

  //   // Print or use the download URL
  //   print('Download URL: $downloadUrl');
  // }

