import 'dart:async';
import 'package:animation_study/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:animation_study/introAnimation.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget> [
              Text('Rabbit Application', style: TextStyle(fontFamily: 'Nanum',
                  fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFFFFB74D)),),
              IntroAnimation()
            ],
            mainAxisAlignment: MainAxisAlignment.center
        ),
      ),
    )
    );
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
  }
}