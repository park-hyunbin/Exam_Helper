import 'package:flutter/material.dart';
import 'dart:io';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:file_picker/file_picker.dart';

import 'exam_screen.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({Key? key}) : super(key: key);

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  String result = "";
  late File userFile;

  void _uploadFile(f) async {
    final file = f;
    final bytes = await file.readAsBytes();
    final text = docxToText(bytes, handleNumbering: true);
    // print(text)
    result = text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamScreen(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 271,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, // 그림자의 색상
              offset: Offset(0, 2), // 그림자의 위치 (수평, 수직)
              blurRadius: 3, // 그림자의 블러 정도
              spreadRadius: 0, // 그림자 확장 정도
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "업로드 해주세요",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.any, allowMultiple: false);
        if (result != null && result.files.isNotEmpty) {
          File file = File(result.files.single.path!);
          userFile = file;
          _uploadFile(userFile);
        } else {}
      },
    );
  }
}
