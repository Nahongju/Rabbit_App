import 'package:flutter/material.dart';

class EndGame extends StatefulWidget {
  int? score;
  EndGame(this.score);

  @override
  State<StatefulWidget> createState() => _EndGame();
}

class _EndGame extends State<EndGame> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    final curve = CurvedAnimation(parent: _animationController!, curve:Curves.bounceIn);
    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -50)).animate(curve);
    _animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: 'rabbit', child: Image.asset('images/intro/rabbit.png'),),
        title: Text('Game Score'),
      ),

      body: Container(
        child: Center(
          child: Column(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  height: 80,
                  child: Text('Game Score\nfor Rabbit Game', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFFB6544)),),
                ),
              ),
              
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  children: <Widget> [
                    Image.asset('images/intro/grass.png', width: 200, height: 200,),

                    Center(
                      child: AnimatedBuilder(
                        animation: _animationController!,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: _animation!.value,
                            child: Image.asset(
                              'images/intro/rabbit.png',
                              width: 100,
                              height: 100,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 80,
                child: Column(
                  children: <Widget> [
                    Text('count for eat : ${widget.score}', style: TextStyle(fontSize: 25),),
                    Text('total score : ${widget.score!.toInt() * 10}', style: TextStyle(fontSize: 25),)
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 200,
                    child: Text('Main Page', style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                  ),
                )
              )
            ], mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}