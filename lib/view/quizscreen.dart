import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotesquiz/helper/AppConstant.dart';
import 'package:quotesquiz/model/qutoesmodel.dart';
import 'package:quotesquiz/services/api_service.dart';
import 'package:quotesquiz/view/completedscreen.dart';
import 'package:quotesquiz/view/splashscreen.dart';
import 'dart:math';
import '../controller/quotesprovider.dart';

class QuizScreen extends ConsumerStatefulWidget {
  int? questionno;
   QuizScreen({super.key, this.questionno});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  late CountDownController _controller;
  int _secondsRemaining = 10;
  late Timer _timer;

  bool nextquestion = false;
  List<QuotesModel> datamodel =[];
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = CountDownController();
    _startTimer();
    if(nextquestion){
      AppConstants.questionno = widget.questionno!;
    }
    if(AppConstants.questionno >= 20){
      _timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompletedScreen()),);

    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      ref.refresh(getQuotesListNotifier);


      if(AppConstants.questionno >= 20){
        _timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompletedScreen()),);
      }
        _secondsRemaining = 10;
      _controller.start();
    });
  }

  List<String> randomAuthors = [];


  @override
  Widget build(BuildContext context) {
    print(AppConstants.questionno++);
    print("this the day");


    return Scaffold(
      body: SafeArea(
        child: ref.watch(getQuotesListNotifier).when(data: (data){
          Random random = Random();
          randomAuthors.clear();
          for (int i = 0; i < 3; i++) {
            int index = random.nextInt(AppConstants.authoroption.length);
            randomAuthors.add(AppConstants.authoroption[index]);
          }
          int newIndex = random.nextInt(randomAuthors.length + 1);
          randomAuthors.insert(newIndex, data.quoteAuthor.toString().isEmpty ? "None of these" : data.quoteAuthor.toString());
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text("Question No:  ${questionno}"),
                      CircularCountDownTimer(
                        duration: 10,
                        controller: _controller,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        fillColor: Colors.purpleAccent[100]!,
                        strokeWidth: 10.0,
                        isReverse: true,
                        backgroundColor: Colors.purple[500],
                        isReverseAnimation: true,
                        autoStart: true,
                        strokeCap: StrokeCap.butt,
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textFormat: CountdownTextFormat.S,
                        onStart: () {
                          debugPrint('Countdown Started');
                        },
                        onChange: (String timeStamp) {
                          debugPrint('Countdown Changed $timeStamp');
                        },
                        timeFormatterFunction: (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {

                            return "0";
                          } else {
                            return Function.apply(defaultFormatterFunction, [duration]);
                          }
                        },
                        onComplete: () {
                          print('Countdown completed');
                        },  ringColor: Colors.grey[300]!,
                      ),


                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(data.quoteText.toString()),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: randomAuthors.length,
                        itemBuilder: (context, int index){
                      return InkWell(
                        onTap: (){
                          print("print it");
                          print(randomAuthors[index].toString());
                          if(randomAuthors[index].toString() == data.quoteAuthor.toString()){
                            AppConstants.totalscore ++;
                            print(" AppConstants.totalscore ++;");
                            print(AppConstants.totalscore);
                          }
                          nextquestion = true;

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizScreen(questionno: AppConstants.questionno,)
                          ),
                          );

                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(child: Text(randomAuthors[index].toString().isEmpty ? "None of these" : randomAuthors[index].toString()))),
                        ),
                      );
                    })

                  ],
                ),
              ],
            ),
          );
        }, error: (e,s){
         return Text(e.toString());
        }, loading: (){
          return Center(child: CircularProgressIndicator());
        })





      ),
    );
  }
}
