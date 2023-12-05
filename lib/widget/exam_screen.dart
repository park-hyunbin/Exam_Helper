import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api/api_key.dart';
import 'dart:convert';
import 'question_screen.dart';
import 'dart:io';

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
    final String endpoint = 'https://api.openai.com/v1/engines/gpt-3.5-turbo-instruct/completions';
    final String apiKey = GPTApiKey;

    // // GPT에게 요청할 프롬프트 구성
    String prompt = '''아래 내용을 기반으로 시험 문제를 5개만 출제하여 json 구조로 줄바꿈 없이 돌려줘. 문제 유형에는 빈칸 채우기와 정답 고르기 유형이 있어. 수업 내용: ${widget.result}
    json 구조: {"Topic": "시험 제목", "Question":[{"QNum": 문항 번호, "QType": "FillBlank", "QContent": 문제, "QAnswer": 정답}, {"QNum": 2, "QType": "SelectAnswer", "QContent": 문제, "QOptions":[{"OptionNum": 1, "OptionContent": 선택지 내용},{"OptionNum": 2,"OptionContent": 선택지 내용},{"OptionNum": 3, "OptionContent": 선택지 내용}, {"OptionNum": 4, "OptionContent": 선택지 내용}], "QAnswer": 정답 번호}]}
    ''';

    // API 요청을 보내고 응답을 받아오는 부분
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'max_tokens': 2500,
          'temperature': 0.6,
      }),
      );

      // 응답이 성공하면 결과물을 가져와서 상태 업데이트
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          summaryResult = data['choices'][0]['text'];
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoQuestionListView(JsonString: summaryResult),
          ),
        );
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // sendToGPT 함수 실행
                  sendToGPT();
                  print(summaryResult);
                },
                child: Text('시험 문제 불러오기'),
              ),
              SizedBox(height: 20)
              // Add other widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}

