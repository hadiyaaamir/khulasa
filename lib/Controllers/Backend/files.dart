import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class Files {
  filePicker(List<String> allowedExtensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    return result;
  }

  Future getMp3() async {
    print('uploading file');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      // allowedExtensions: ['mp3'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.path);
      var filee = File(file.path!);
      filee.createSync();

      return filee;
    }
    return null;
  }

  Future<String?> getText() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String? p = file.path;
      //image using flutter tesseract ocr
      if ((file.extension == 'png' || file.extension == 'jpg') && p != null) {
        return await FlutterTesseractOcr.extractText(p, language: 'urd+eng');
      }
    }
    return null;
  }
}
