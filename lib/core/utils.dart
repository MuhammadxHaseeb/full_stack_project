import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickAudio() async {
  try{
    final filePickerRes = await FilePicker.pickFiles(
      type: FileType.audio,
    );

    if (filePickerRes != null)
    {
      final path = filePickerRes.files.first.path;
      
      if (path != null)
      {
        return File(path);
      }
    }
    return null;

  }
  catch (e) {
    return null;
  }
}


Future<File?> pickImage() async {
  try{
    final filePickerRes = await FilePicker.pickFiles(
      type: FileType.image,
    );

    if (filePickerRes != null)
    {
      final path = filePickerRes.files.first.path;
      
      if (path != null)
      {
        return File(path);
      }
    }
    return null;

  }
  catch (e, stackTrace) {
    print('PICK IMAGE ERROR: $e');
    print(stackTrace);
    return null;
  }
}