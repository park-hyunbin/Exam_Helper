import 'package:examhelper/detail.dart';
import 'package:examhelper/widget/calendar.dart';
import 'package:examhelper/widget/uploadFile.dart';
import 'package:flutter/material.dart';
import 'widget/bottom_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> examTitles = [
    "실용영문법 기말고사 대비",
    "소프트웨어공학 기말고사 대비",
    "QUIZ 대비",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExamHelper',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const CalendarPage()),
                  ],
                ),
              ),
              Container(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 380,
                    //   height: 500,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: const Color.fromRGBO(
                    //             255, 214, 186, 1.0), // 테두리 색상 설정
                    //         width: 5.0, // 테두리 선의 두께 설정
                    //       ),
                    //       borderRadius: BorderRadius.circular(20)),
                    // ),
                    SizedBox(height: 30),
                    UploadFile()
                  ],
                ),
              ),
              ListView.builder(
                key: const PageStorageKey("LIST_VIEW"),
                itemCount: examTitles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuestionListView(),
                          ),
                        );
                      },
                      child: Container(
                        width: 380,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFBEE3DB),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            ('${examTitles[index]}\n맞은 개수 : 7/10'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: const Bottom(),
        ),
      ),
    );
  }
}
