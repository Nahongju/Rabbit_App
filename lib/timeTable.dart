import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeTable();
}

class _TimeTable extends State<TimeTable> {
  List<String>? subject;
  Color subjectColor = Colors.white;

  @override
  void initState() {
    super.initState();
    subject = [
      '', '월', '화', '수', '목', '금',
      '1교시', '프로S', '게임프', '미술', '게임프', '미술',
      '2교시','프로S', '게임프', '미술', '게임프', '음악',
      '3교시','국어', '게임프', '수학', '게임프', '영어',
      '4교시','수학', '프로S', '창체', '통합사회', '통합사회',
      '5교시','체육', '프로S', '일본어', '컴퓨터\n구조', '창체',
      '6교시','영어', '프로S', '통합사회', '컴퓨터\n구조', 'H.R',
      '7교시','일본어', '국어', '', '컴퓨터\n구조', 'C.A' ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
        actions: <Widget> [
          Hero(tag: 'rabbit', child: Image.asset('images/intro/rabbit.png'),)
        ],
      ),

      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
            itemBuilder: (context, index) {
              return GridTile(
                child: Card(
                    child: Column(
                      children: <Widget> [
                        Text(subject![index], textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
                      ], mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  color: changeSubjectColor(index, subject![index]),
                ),
              );
            },
            itemCount: subject!.length,
          ),
        )
      ),
    );
  }

  Color changeSubjectColor(int index, String subject) {
    if(subject == '국어') {
      return Color(0xFFBFC8D7);
    } else if(subject == '수학') {
      return Color(0xFFE2D2D2);
    } else if(subject == '영어') {
      return Color(0xFFE3E2B4);
    } else if(subject == '통합사회') {
      return Color(0xFFA2B59F);
    } else if(subject == '체육') {
      return Color(0xFFE8E7DE);
    } else if(subject == '음악') {
      return Color(0xFFC9BA9B);
    } else if(subject == '일본어') {
      return Color(0xFFF9D9CA);
    } else if(subject == '미술') {
      return Color(0xFFE4A99B);
    } else if(subject == '프로S') {
      return Color(0xFFC5DAD1);
    } else if(subject == '게임프') {
      return Color(0xFFC9CBE0);
    } else if(subject == '창체') {
      return Color(0xFFEEB8B8);
    } else if(subject == '컴퓨터\n구조') {
      return Color(0xFFAEDDEF);
    }


    return Color(0xFFFFFFFF);
  }
}