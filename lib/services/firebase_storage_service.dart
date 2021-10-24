import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_portfolio/services/firebase_auth_service.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String?> getFilePath() async {
    final ImagePicker _picker = ImagePicker();
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return xFile.path;
    }
    return null;
  }

  UploadTask? uploadFile(String filePath) {
    File file = File(filePath);
    try {
      return firebase_storage.FirebaseStorage.instance
          .ref(
              '${FirebaseAuthService.instance.getUserUniqueId()}/raw-images/${FirebaseAuthService.instance.getUniqueFileName()}.png')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return null;
    }
  }
}
