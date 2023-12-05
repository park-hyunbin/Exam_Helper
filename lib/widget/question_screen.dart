import 'dart:convert';
import 'package:flutter/material.dart';

class DoQuestionListView extends StatefulWidget {
  final String JsonString;
  DoQuestionListView({required this.JsonString});

  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<DoQuestionListView> {
  late List<Map<String, dynamic>> questions = [];
  Map<int, dynamic> userAnswers = {};

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

  String problem = '''
{"Topic": "관계대명사 시험", "Question": [{"QNum": 1, "QType": "FillBlank", "QContent": "The person ___ is standing over there is my friend.", "QAnswer": "who"}, {"QNum": 2, "QType": "SelectAnswer", "QContent": "I met a woman ___ I had not seen in years.", "QOptions": [{"OptionNum": 1, "OptionContent": "where"}, {"OptionNum": 2, "OptionContent": "when"}, {"OptionNum": 3, "OptionContent": "whose"}, {"OptionNum": 4, "OptionContent": "that"}], "QAnswer": 3}, {"QNum": 3, "QType": "FillBlank", "QContent": "I bought a new car ___ is very fuel efficient.", "QAnswer": "which"}, {"QNum": 4, "QType": "FillBlank", "QContent": "This is the book ___ I was talking about.", "QAnswer": "that"}, {"QNum": 5, "QType": "SelectAnswer", "QContent": "The man ___ car was stolen reported it to the police.", "QOptions": [{"OptionNum": 1, "OptionContent": "who"}, {"OptionNum": 2, "OptionContent": "whose"}, {"OptionNum": 3, "OptionContent": "where"}, {"OptionNum": 4, "OptionContent": "why"}], "QAnswer": 2}]}
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
