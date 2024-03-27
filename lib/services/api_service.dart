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





}


