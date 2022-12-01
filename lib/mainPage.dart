import 'package:animation_study/bookInfo.dart';
import 'package:animation_study/miniGame.dart';
import 'package:animation_study/subjectPage.dart';
import 'package:animation_study/timeTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  List<String> btnText = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    btnText.add('Time\nTable');
    btnText.add('Subject');
    btnText.add('Mini\nGame');
    btnText.add('?');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = onWillPop();
        return await Future.value(result);
      },

      child: Scaffold(
        appBar: AppBar(
          leading: Hero(tag: 'rabbit', child: Image.asset('images/intro/rabbit.png'),),
          title: Text('Main Page'),
        ),

        body: Container(
          child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: Container(
                          color: index == 0 || index == 3? Color(0xFFFFB74D): Color(0xFFFFE0B2),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                if(index == 0) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimeTable()));
                                }

                                if(index == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubjectPage()));
                                }

                                if(index == 2) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MiniGame()));
                                }

                                if(index == 3) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookInfo()));
                                }
                              },
                              child: Text(btnText[index], style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            ),
                          ),
                        )
                    );
                  },
                  itemCount: btnText.length,
                ),
              )
          ),
        ),
      ),
    );
  }

  onWillPop() {
    bool? existApp;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Rabbit App을 종료하시겠습니까?'),
          actions: <Widget> [
            TextButton(
              child: Text('아니오'),
              onPressed: () {
                Navigator.of(context).pop();
                existApp = false;
              },
            ),

            TextButton(
              child: Text('예'),
              onPressed: () {
                SystemNavigator.pop();
                existApp = true;
              },
            )
          ],
        );
      }
    );

    return existApp;
  }
}