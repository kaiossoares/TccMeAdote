import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'firebase_storage_service.dart';

class ImagePickerService {
  final _picker = ImagePicker();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();

  Future<List<String>?> uploadImages(List<File> imageFiles, String storagePath) async {
    try {
      List<String> imageUrls = await _firebaseStorageService.uploadImages(imageFiles, storagePath);
      return imageUrls;
    } catch (e) {
      print('Erro durante o processo de upload das imagens: $e');
      throw 'Erro durante o processo de upload das imagens.';
    }
  }

  Future<List<XFile>?> pickImages() async {
    try {
      List<XFile>? pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.length > 4) {
        return pickedFiles.sublist(0, 4);
      }
      return pickedFiles;
    } catch (e) {
      print('Erro durante o processo de seleção das imagens: $e');
      throw 'Erro durante o processo de seleção das imagens.';
    }
  }

}
