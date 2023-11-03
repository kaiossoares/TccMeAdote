import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<File> imageFiles, String storagePath) async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFiles.length; i++) {
        String uniqueFileName = generateUniqueFileName(imageFiles[i]);

        Reference storageReference = _storage.ref().child('$storagePath/$uniqueFileName');

        UploadTask uploadTask = storageReference.putFile(imageFiles[i]);
        await uploadTask;

        String imageUrl = await storageReference.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      return imageUrls;
    } catch (e) {
      print('Erro ao fazer upload das imagens: $e');
      throw 'Erro ao fazer upload das imagens.';
    }
  }

  String generateUniqueFileName(File file) {
    String fileName = file.path.split('/').last;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$timestamp-$fileName';
  }
}
