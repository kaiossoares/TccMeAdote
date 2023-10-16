import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<File> imageFiles, String storagePath) async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFiles.length; i++) {
        Reference storageReference = _storage.ref().child('$storagePath/image_$i.jpg');
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
}
