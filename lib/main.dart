import 'package:examhelper/detail.dart';
import 'package:examhelper/widget/calendar.dart';
import 'package:flutter/material.dart';
import 'widget/bottom_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 380,
                      height: 500,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(
                                255, 214, 186, 1.0), // 테두리 색상 설정
                            width: 5.0, // 테두리 선의 두께 설정
                          ),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
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
                    ),
                  ],
                ),
              ),
              ListView.builder(
                key: const PageStorageKey("LIST_VIEW"),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the details page when the item is clicked
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
                            "Exam ${index + 1}",
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
