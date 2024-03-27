import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotesquiz/controller/quotesprovider.dart';
import 'package:quotesquiz/helper/AppConstant.dart';
import 'package:quotesquiz/view/quizscreen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text(
                'Login Now',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      //readOnly: true,
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: 'User Name',
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onChanged: (value) {
                        // do something
                      },
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onChanged: (value) {
                        // do something
                      },
                    ),
                    SizedBox(height: 25.0),


                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.purple),
                        ),
                        onPressed: () async{
                          if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                            await ref.read(getQuotesListNotifier);
                            var snackBar = SnackBar(content: Text('Login Success!!!!'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            AppConstants.username = usernameController.text;
                            AppConstants.password = passwordController.text;
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizScreen()),);
                          }else{
                            var snackBar = SnackBar(content: Text('Something went wrong. Try again!!!!'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }


                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
