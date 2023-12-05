import 'dart:convert';
import 'package:flutter/material.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({Key? key}) : super(key: key);

  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  late List<Map<String, dynamic>> questions = [];

  Map<int, dynamic> userAnswers = {};

  @override
  void initState() {
    super.initState();
    loadQuestions(problem);
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
{
  "Topic": "관계 대명사 문법 문제:",
  "Question": [
    {
      "QNum": 1,
      "QType": "FillBlank",
      "QContent": "Fill in the blanks with the appropriate relative pronoun ('who', 'whose', 'that', 'which'): \\nThe girl ________ won the first prize in the art competition is my neighbor.",
      "QAnswer": "who"
    },
    {
      "QNum": 2,
      "QType": "SelectAnswer",
      "QContent": "Choose the appropriate relative pronoun ('who', 'whose', 'that', 'which'): \\nI know a scientist ________ research focuses on environmental sustainability.",
      "QOptions": [
        {
          "OptionNum": 1,
          "OptionContent": "who"
        },
        {
          "OptionNum": 2,
          "OptionContent": "whose"
        },
        {
          "OptionNum": 3,
          "OptionContent": "that"
        },
        {
          "OptionNum": 4,
          "OptionContent": "which"
        }
      ],
      "QAnswer": 2
    }
  ]
}
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
