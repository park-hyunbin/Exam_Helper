import 'package:flutter/material.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({Key? key}) : super(key: key);

  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  final List<Map<String, dynamic>> questions = [
    {
      "QNum": 1,
      "QType": "FillBlank",
      "QContent":
          "Fill in the blanks with the appropriate relative pronoun ('who', 'whose', 'that', 'which'): \nThe girl ________ won the first prize in the art competition is my neighbor.",
      "QAnswer": "who",
    },
    {
      "QNum": 2,
      "QType": "SelectAnswer",
      "QContent":
          "Choose the appropriate relative pronoun ('who', 'whose', 'that', 'which'): \nI know a scientist ________ research focuses on environmental sustainability.",
      "QOptions": [
        {"OptionNum": 1, "OptionContent": "who"},
        {"OptionNum": 2, "OptionContent": "whose"},
        {"OptionNum": 3, "OptionContent": "that"},
        {"OptionNum": 4, "OptionContent": "which"},
      ],
      "QAnswer": 2,
    },
    {
      "QNum": 3,
      "QType": "SelectAnswer",
      "QContent":
          "Choose the appropriate relative pronoun ('who', 'whose', 'that', 'which'): \nI know a scientist ________ research focuses on environmental sustainability.",
      "QOptions": [
        {"OptionNum": 1, "OptionContent": "who"},
        {"OptionNum": 2, "OptionContent": "whose"},
        {"OptionNum": 3, "OptionContent": "that"},
        {"OptionNum": 4, "OptionContent": "which"},
      ],
      "QAnswer": 2,
    },
    {
      "QNum": 4,
      "QType": "FillBlank",
      "QContent":
          "Fill in the blanks with the appropriate relative pronoun ('who', 'whose', 'that', 'which'): \nThe girl ________ won the first prize in the art competition is my neighbor.",
      "QAnswer": "who",
    },
  ];

  Map<int, dynamic> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
                  if (questions[index]["QType"] == "SelectAnswer")
                    DropdownButtonFormField(
                      value: userAnswers[index + 1],
                      items: (questions[index]["QOptions"]
                              as List<Map<String, dynamic>>)
                          .map((option) {
                        return DropdownMenuItem(
                          value: option["OptionNum"],
                          child: Text(option["OptionContent"]),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          userAnswers[index + 1] = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Answer',
                        border: OutlineInputBorder(),
                      ),
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
