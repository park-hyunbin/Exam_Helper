import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api/api_key.dart';

class ExamScreen extends StatefulWidget {
  final String result;
  ExamScreen({required this.result});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  String summaryResult = '';

  Future<void> sendToGPT() async {
    // GPT API 요청을 위한 엔드포인트와 API 키 설정 (실제 사용하는 API에 따라 수정 필요)
    final String endpoint = 'YOUR_GPT_API_ENDPOINT';
    final String apiKey = 'YOUR_API_KEY';

    // GPT에게 요청할 프롬프트 구성
    String prompt = 'Summarize the following text: ${widget.result}';

    // API 요청을 보내고 응답을 받아오는 부분
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: '{"prompt": "$prompt"}',
      );

      // 응답이 성공하면 결과물을 가져와서 상태 업데이트
      if (response.statusCode == 200) {
        setState(() {
          summaryResult = response.body;
        });
      } else {
        // 응답이 실패한 경우에 대한 처리
        print('Failed to get response from GPT. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // 예외가 발생한 경우에 대한 처리
      print('Error while sending request to GPT: $error');
    }
  }

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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // sendToGPT 함수 실행
                sendToGPT();
              },
              child: Text('Send to GPT'),
            ),
            SizedBox(height: 20),
            Text(
              'Summary from GPT: $summaryResult',
              style: TextStyle(fontSize: 18),
            ),
            // Add other widgets as needed
          ],
        ),
      ),
    );
  }
}
