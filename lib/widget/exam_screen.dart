import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  final String result;
  ExamScreen({required this.result});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result from Upload: ${widget.result}',
              style: TextStyle(fontSize: 18),
            ),
            // Add other widgets as needed
          ],
        ),
      ),
    );
  }
}
