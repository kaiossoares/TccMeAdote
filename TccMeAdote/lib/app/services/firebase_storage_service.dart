import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(File imageFile, String storagePath) async {
    try {
      String uniqueFileName = generateUniqueFileName(imageFile);

      Reference storageReference = _storage.ref().child('$storagePath/$uniqueFileName');

      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask;

      String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      throw 'Erro ao fazer upload da imagem.';
    }
  }

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
