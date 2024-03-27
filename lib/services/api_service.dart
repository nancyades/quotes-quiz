import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quotesquiz/model/loginmodel.dart';
import 'package:quotesquiz/model/qutoesmodel.dart';


Provider<Api_Proider> api_provider =
Provider<Api_Proider>((ref) => Api_Proider(ref));

class Api_Proider {
  final Ref? ref;

  Api_Proider(this.ref);

  Future<dynamic> getquotesquiz() async {
    QuotesModel quotesquiz;
    try {

      final response = await http.get(Uri.parse('http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en'));
      if (response.statusCode == 200) {
        String jsonData = response.body;
    jsonData = jsonData.replaceAll(r"\'", "'");
    Map<String, dynamic> data = json.decode(jsonData);
        quotesquiz = QuotesModel.fromJson(data);
        return quotesquiz;
      } else {
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      print("i found it nancy");
    }
  }


  Future<UserModel?> createUser(String username, String password) async {
    var url = Uri.parse('https://dummyjson.com/auth/login');
    var data = {
      "username": "${username}",
      "password": "${password}"
    };
    var jsonBody = jsonEncode(data);
    var response = await http.post(url,
      headers: {'Content-Type': 'application/json' },
      body: jsonBody,
    );
    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      var user = UserModel.fromJson(responseData);
      print('User created successfully:');
      print('Name: ${user.firstName}');
      print('Job: ${user.email}');
      print('ID: ${user.id}');
      print('Created At: ${user.username}');
      return user;
    } else {
      print('Failed to create user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }


}


