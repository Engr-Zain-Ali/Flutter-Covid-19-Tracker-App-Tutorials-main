import 'dart:async';
import 'dart:html';

import 'package:covid_tracker/View/Next_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final  AnimationController _animationController=AnimationController(
      duration:const Duration(seconds:5),
      vsync: this)..repeat();
void dispose(){
  super.dispose();
  _animationController.dispose();
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer( Duration(seconds:6),
            () =>Navigator.push(context,MaterialPageRoute(builder: (context)=>NextScreen())),
    );

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(animation: _animationController,
                child: Container(
                  width: 200,
                  height: 200,
                  child:const Center(child: Image(image:AssetImage('images/virus.png'), ),
                  ),
                ),
                builder: (BuildContext context,Widget?child){
              return Transform.rotate(angle: _animationController.value*2.0*math.pi,
              child: child,
              );
                }
            ),
            SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.center,
                child: Text('Covid-19\nTracker_App',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.deepOrange.withOpacity(.7)),))
          ],
        ),
      ),
    );
  }
}
