import 'package:flutter/material.dart';
import 'dart:async';

class IntroAnimation extends StatefulWidget {
  _IntroAnimation _introAnimation = _IntroAnimation();
  @override
  State<StatefulWidget> createState() => _introAnimation;

  void start() {
    _introAnimation.start();
  }

  void stop() {
    _introAnimation.stop();
  }
}

class _IntroAnimation extends State<IntroAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _scaleAnimation;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
    _animationController!.forward();
    setRabbit();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
      return SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: <Widget> [
            Transform.scale(
              scale: _scaleAnimation!.value,
              child: Image.asset(
                'images/intro/grass.png',
                width: 200,
                height: 200,
              ),
            ),

            Center(
             child: AnimatedOpacity(
               opacity: _opacity,
               duration: Duration(seconds: 3),
               child: Hero(tag: 'rabbit',
                   child: Image.asset('images/intro/rabbit.png', width: 100, height: 100,)),
             ),
            )
          ],
        ),
      );
        }
    );
  }

  Future<Timer> setRabbit() async {
    return Timer(Duration(seconds: 2), () {
      _opacity == 0? _opacity = 1: _opacity = 0;
    });
  }

  void start() {
    _animationController!.forward();
  }

  void stop() {
    _animationController!.stop(canceled: true);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}