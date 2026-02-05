import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();

  /// Pick an image from gallery or camera
  Future<XFile?> pickImage({bool fromCamera = false}) async {
    return await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
  }

  /// Upload file to Firebase Storage and return download URL
  Future<String?> uploadImage(XFile file, {String folder = 'uploads/user_images'}) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('$folder/$fileName.jpg');
      await ref.putFile(File(file.path));
      return await ref.getDownloadURL();
    } catch (e) {
      print('Upload failed: $e');
      return null;
    }
  }

  /// Delete file from Firebase Storage by URL
  Future<void> deleteImageByUrl(String url) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
    } catch (e) {
      print('Delete failed: $e');
    }
  }
}
