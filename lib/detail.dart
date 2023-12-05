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
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/json/problem.json');
    Map<String, dynamic> jsonResult = jsonDecode(jsonString);
    List<Map<String, dynamic>> loadedQuestions =
        List<Map<String, dynamic>>.from(jsonResult['Question'] ?? []);
    setState(() {
      questions = loadedQuestions;
    });
  }

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
