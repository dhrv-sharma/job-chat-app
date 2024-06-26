import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

Future<File?> pickImage(String name) async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
  final cloudinary = CloudinaryPublic("dap69mong", "rwdctipx");

  if (result != null) {
    File file = File(result.files.first.path!);
    CloudinaryResponse res = await cloudinary
        .uploadFile(CloudinaryFile.fromFile(file.path, folder: name));

    return file;
  }

  return null;
}
