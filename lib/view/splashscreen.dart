import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotesquiz/controller/quotesprovider.dart';
import 'package:quotesquiz/helper/AppConstant.dart';
import 'package:quotesquiz/services/api_service.dart';
import 'package:quotesquiz/view/loginscreen.dart';
import 'package:quotesquiz/view/quizscreen.dart';


class SplashScreen extends ConsumerStatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), ()async {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff37b3da),
                Color(0xffeac7ef),
                Color(0xff5b46e7),
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child:   Text('Quotes Quiz',style: TextStyle(color: Colors.white,fontSize: 50, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

