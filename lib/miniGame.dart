import 'package:animation_study/endGame.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MiniGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MiniGame();
}

class _MiniGame extends State<MiniGame> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _transAnimation1;
  Animation? _transAnimation2;
  Animation? _transAnimation3;
  int randNum = 0;
  int randJump = 0;
  int count = 0;
  int sameCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _transAnimation1 = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -100)).animate(_animationController!);
    _transAnimation2 = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -150)).animate(_animationController!);
    _transAnimation3 = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -300)).animate(_animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget> [Hero(tag: 'rabbit',
          child: Image.asset('images/intro/rabbit.png'),),],
        title: Text('Rabbit Game'),
      ),

      body: Container(
        child: Center(
          child: Column(
            children: <Widget> [
              SizedBox(
                  child: Row(
                    children: <Widget> [
                      Text('Jump 횟수 : ${count}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      SizedBox(width: 30,),
                      Text('토끼가 당근을 먹은 횟수 : ${sameCount}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                    ], mainAxisAlignment: MainAxisAlignment.spaceAround,
                  )
              ),

              SizedBox(
                  height: 500,

                  child: Stack(
                    children: <Widget> [
                      // 당근 애니메이션
                      Transform.translate(
                          offset: randNum == 0? _transAnimation1!.value: randNum == 1? _transAnimation2!.value: _transAnimation3!.value,
                          child: Column(
                            children: <Widget> [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                    'images/intro/carrot.png'
                                ),
                          )
                          ], mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      ),

                      // 토끼 애니메이션
                      Transform.translate(
                        offset: randJump == 0? _transAnimation1!.value : randJump == 1? _transAnimation2!.value : _transAnimation3!.value,
                        child: Column(
                          children: <Widget> [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                  'images/intro/rabbit.png'
                              ),
                            )
                          ], mainAxisAlignment: MainAxisAlignment.end,
                        ),
                      )
                    ],
                  )
              ),

              SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        randJump = jumpRandom();
                        randNum = randomNumber();
                        _animationController!.forward();

                        if(randJump == randNum) {
                          sameCount++;
                        }

                        count++;

                        if(count == 10) {
                          // count 값이 10보다 클 경우, pushReplaceMent를 통해 다른 페이지로 이동해 게임이 종료했음을 알리기
                          // 다른 페이지로 넘어갈 때, sameCount 값을 넘겨 토끼가 먹은 횟수 출력
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EndGame(sameCount)));
                        }
                      });
                    },
                    child: Text('Jump'),
                  )
              )
            ], mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  int jumpRandom() {
    int jump = Random().nextInt(10) % 3;

    return jump;
  }

  // 랜덤 값 뽑기
  int randomNumber() {
    int num = Random().nextInt(10) % 3;

    return num;
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}