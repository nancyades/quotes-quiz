import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotesquiz/controller/quotesprovider.dart';
import 'package:quotesquiz/helper/AppConstant.dart';
import 'package:quotesquiz/view/loginscreen.dart';
import 'package:quotesquiz/view/quizscreen.dart';

class CompletedScreen extends ConsumerStatefulWidget {
  const CompletedScreen({super.key});

  @override
  ConsumerState<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends ConsumerState<CompletedScreen> {
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
            Color(0xffca54d9),
            Color(0xff401046),
          ],
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'User Name: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        AppConstants.username,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        AppConstants.totalscore.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    AppConstants.totalscore >= 10
                        ? 'congratulations your completed Quiz'
                        : "Sorry your score is low",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: ()  {

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1.5,
                            color: Colors.purple,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Thank you",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  )

          ],
        ),
      ),
    );
  }
}
