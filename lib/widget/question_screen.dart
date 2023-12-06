import 'dart:convert';
import 'package:flutter/material.dart';

class DoQuestionListView extends StatefulWidget {
  final String JsonString;
  const DoQuestionListView({super.key, required this.JsonString});

  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<DoQuestionListView> {
  late List<Map<String, dynamic>> questions = [];
  Map<int, dynamic> userAnswers = {};
  bool showResults = false;

  @override
  void initState() {
    super.initState();
    loadQuestions(widget.JsonString);
  }

  Future<void> loadQuestions(String jsonString) async {
    Map<String, dynamic> jsonResult = jsonDecode(jsonString);
    List<Map<String, dynamic>> loadedQuestions =
        List<Map<String, dynamic>>.from(jsonResult['Question'] ?? []);
    setState(() {
      questions = loadedQuestions;
    });
  }

  void checkAnswers() {
    setState(() {
      showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBEE3DB),
        elevation: 0.0,
        title: const Text(
          '문제 풀기',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: checkAnswers,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: questions == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(
                      'Q${questions[index]["QNum"]}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questions[index]["QContent"],
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        if (questions[index]["QType"] == "FillBlank")
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Your Answer',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              userAnswers[index + 1] = value;
                            },
                          ),
                        const SizedBox(height: 10),
                        if (showResults)
                          Text(
                            '정답: ${questions[index]["QAnswer"]}',
                            style: TextStyle(
                              color: userAnswers[index + 1] ==
                                      questions[index]["QAnswer"]
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        Column(
                          children: (questions[index]["QOptions"]
                                      as List<dynamic>?)
                                  ?.map((option) {
                                if (option is Map<String, dynamic>) {
                                  return RadioListTile(
                                    title: Text(option["OptionContent"] ?? ''),
                                    value: option["OptionNum"],
                                    groupValue: userAnswers[index + 1],
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswers[index + 1] = value;
                                      });
                                    },
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }).toList() ??
                              [],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
