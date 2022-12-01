import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:animation_study/main.dart';
import 'subject.dart';

class SubjectPage extends StatefulWidget {
  Future<Database> db = MyApp().createDatabase();

  @override
  State<StatefulWidget> createState() => _SubjectPage();
}

class _SubjectPage extends State<SubjectPage> {
  Future<List<Subject>>? subjectList;
  TextEditingController? input_title;
  TextEditingController? input_content;
  TextEditingController? input_day;

  @override
  void initState() {
    super.initState();
    subjectList = showSubjectList();
    input_title = TextEditingController();
    input_content = TextEditingController();
    input_day = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Subject List'),
          actions: <Widget> [
            Hero(tag: 'rabbit', child: Image.asset('images/intro/rabbit.png'),)
          ],
        ),

        body: Container(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();

                case ConnectionState.waiting:
                  return CircularProgressIndicator();

                case ConnectionState.active:
                  return CircularProgressIndicator();

                case ConnectionState.done:
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Subject subject = (snapshot.data as List<Subject>)[index];

                        return GestureDetector(
                          child: Card(
                              color: Color(0xFFFFE0B2),
                              child: Container(
                                child: Row(
                                  children: <Widget> [
                                    SizedBox(
                                      width: 40,
                                      child: subject.done! == 1? Icon(Icons.cruelty_free_outlined) : Icon(Icons.compost),
                                    ),

                                    Flexible(
                                      child: SizedBox(
                                        child: Column(
                                          children: <Widget> [
                                            Text('< 과목명 : ${subject.title!} >', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                            Text(subject.content!, style: TextStyle(fontSize: 15),),
                                            Text('- 마감 : ${subject.day!}')
                                          ], mainAxisAlignment: MainAxisAlignment.start,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),

                          onTap: () async {
                            // 완료한 일 체크
                            Subject result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('완료'),
                                    content: Text('과제를 완료했습니까?'),
                                    actions: <Widget> [
                                      ElevatedButton(
                                          onPressed: () {
                                            subject.done = 1;
                                            Navigator.of(context).pop(subject);
                                          },
                                          child: Text('예')
                                      ),

                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(subject);
                                        },
                                        child: Text('아니오'),
                                      )
                                    ],
                                  );
                                }
                            );

                            updateSubject(result);
                          },
                        );
                      },
                      itemCount: (snapshot.data as List<Subject>).length,
                    );
                  }
              }

              return Text('No Data');
            },
            future: subjectList,
          ),
        ),

        floatingActionButton: Column(
          children: <Widget> [
            FloatingActionButton(
              heroTag: 'f1',
              onPressed: () async {
                // 과제 추가 페이지로 넘어가기 or 과제 추가 다이얼로그 넣기
                Subject result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: SizedBox(
                          child: Row(
                            children: <Widget> [
                              Text('과제 추가', style: TextStyle(fontWeight: FontWeight.bold),),
                            ], mainAxisAlignment: MainAxisAlignment.spaceAround,
                          ),
                        ),

                        content:SingleChildScrollView(
                          child:  Container(
                            child: Center(
                              child: Column(
                                children: <Widget> [
                                  TextField(controller: input_title, keyboardType: TextInputType.text, maxLength: 7, decoration: InputDecoration(labelText: '과목명'),),
                                  TextField(controller: input_content, keyboardType: TextInputType.text, maxLength: 10, decoration: InputDecoration(labelText: '과제 내용'),),
                                  TextField(controller: input_day, keyboardType: TextInputType.datetime, decoration: InputDecoration(labelText: 'yyyy/MM/dd'),)
                                ],
                              ),
                            ),
                          ),
                        ),

                        actions: <Widget> [
                          ElevatedButton(
                            child: Text('취소'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),

                          ElevatedButton(
                            child: Text('추가'),
                            onPressed: () {
                              Subject subject = Subject(
                                  title: input_title!.value.text,
                                  content: input_content!.value.text,
                                  day: input_day!.value.text,
                                  done: 0
                              );

                              Navigator.of(context).pop(subject);
                            },
                          )
                        ],
                      );
                    }
                );

                if(result != null) {
                  // insert 함수 호출
                  insertSubject(result);
                }
              },
              child: Icon(Icons.add),
            ),

            SizedBox(height: 10,),

            FloatingActionButton(
              heroTag: 'f2',
              onPressed: () {
                // 완료된 목록 삭제하는 버튼
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('삭제'),
                        content: Text('완료한 과제를 삭제하겠습니까?'),
                        actions: <Widget> [
                          ElevatedButton(onPressed: () {
                            deleteSubject();
                            Navigator.of(context).pop();
                          }, child: Text('확인')),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('취소'),
                          )
                        ],
                      );
                    }
                );
              },
              child: Icon(Icons.remove),
            )
          ], mainAxisAlignment: MainAxisAlignment.end,
        )
    );
  }

  Future<List<Subject>> showSubjectList() async {
    final Database database = await widget.db;
    List<Map<String, dynamic>> maps = await database.query('sub');

    return List.generate(maps.length, (index) {
      return Subject(
          title: maps[index]['title'].toString(),
          content: maps[index]['content'].toString(),
          day: maps[index]['day'].toString(),
          done: maps[index]['done'],
          id: maps[index]['id']
      );
    });
  }

  void insertSubject(Subject subject) async {
    final Database database = await widget.db;
    await database.insert('sub', subject.maps(), conflictAlgorithm: ConflictAlgorithm.replace);

    setState(() {
      subjectList = showSubjectList();
    });
  }

  void updateSubject(Subject subject) async {
    final Database database = await widget.db;
    await database.update('sub', subject.maps(), where: 'id=?', whereArgs: [subject.id]);

    setState(() {
      subjectList = showSubjectList();
    });
  }

  void deleteSubject() async {
    final Database database = await widget.db;
    database.rawDelete('delete from sub where done=1');

    setState(() {
      subjectList = showSubjectList();
    });
  }
}