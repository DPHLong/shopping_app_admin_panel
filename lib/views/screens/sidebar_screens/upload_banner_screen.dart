import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '\UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Uint8List? _image;
  String? _fileNameAndExtension;

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      String fileNameAndExtension = result.files.first.name;
      debugPrint('--- file name $fileNameAndExtension ---');
      setState(() {
        _image = fileBytes;
        _fileNameAndExtension = fileNameAndExtension;
      });
    } else {
      debugPrint('--- No image selected. ---');
    }
  }

  Future<String> _uploadBannerToStorage(
    Uint8List image,
    String fileNameAndExtension,
  ) async {
    final ref = _storage.ref().child('banners').child(fileNameAndExtension);
    final uploadTask = ref.putData(image);
    final taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    debugPrint('--- download url: $downloadUrl ---');
    return downloadUrl;
  }

  _uploadToFirestore() async {
    EasyLoading.show(status: 'Uploading...');
    if (_image != null) {
      final imageUrl = await _uploadBannerToStorage(
        _image!,
        _fileNameAndExtension!,
      );
      await _firestore
          .collection('banners')
          .doc(_fileNameAndExtension)
          .set({
            'imageUrl': imageUrl,
            'fileName': _getName(_fileNameAndExtension!),
            'extension': _getExtension(_fileNameAndExtension!),
          })
          .whenComplete(() {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Uploaded successfully');
            setState(() {
              _image = null;
              _fileNameAndExtension = null;
            });
          });
    } else {
      debugPrint('--- No image selected. ---');
    }
  }

  static String _getName(String fileName) {
    try {
      final name = fileName.split('.').first;
      if (name.isNotEmpty) return name;
    } catch (_) {}
    return 'file';
  }

  static String _getExtension(String fileName) {
    // include cases where the file name has more than 1 extension also no extensions
    try {
      final name = _getName(fileName);
      final ext = fileName.replaceAll(name, '').trim();
      if (ext.isNotEmpty) return ext;
    } catch (_) {}
    return '.txt';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Banners',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          ),
        ),
        Divider(color: Colors.grey),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade500,
                    ),
                    child:
                        _image != null
                            ? Image.memory(_image!, fit: BoxFit.cover)
                            : Center(child: Text('Banner Image')),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _pickImage(),
                    child: Text(
                      'Pick Image',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade900,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => _uploadToFirestore(),
              child: Text('Upload', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade900,
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Banners',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          ),
        ),
        BannerWidget(),
      ],
    );
  }
}
