import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

void pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final res = result.files.single;
    uploadFile(res);
  }
}

Reference ref(String name) => FirebaseStorage.instance.ref().child(name);

void uploadFile(PlatformFile data) async {
  // Create a Reference to the file
  final bytes = data.bytes ?? (File(data.path!).readAsBytesSync());
  ref(data.name).putData(bytes);
}

void download(String name) {
  ref(name).getDownloadURL();
}

void remove(String name) {
  ref(name).delete();
}
