import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const SizedBox(
        height: 100,
        child: TabBar(
          labelColor: Color(0xFF89B0AE),
          unselectedLabelColor: Color(0xFFBEE3DB),
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 32,
              ),
              child: Text(
                '홈',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.add_box_outlined,
                size: 32,
              ),
              child: Text(
                '업로드',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.quiz,
                size: 32,
              ),
              child: Text(
                '퀴즈',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
