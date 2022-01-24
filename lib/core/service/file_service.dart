import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FileService {
  static Future<File> getImage() async {
    final picker = ImagePicker();
    File file;
    final pickerFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxHeight: 1080,
        maxWidth: 720);
    if (pickerFile != null) {
      file = File(pickerFile.path);
    } else {
      print('No image selected');
    }
    return file;
  }

  static Future<File> getImageCamera() async {
    final picker = ImagePicker();
    File file;
    final pickerFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 40,
        maxHeight: 720,
        maxWidth: 480);
    if (pickerFile != null) {
      file = File(pickerFile.path);
    } else {
      print('No image selected');
    }
    return file;
  }
}
