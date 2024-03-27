import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotesquiz/model/loginmodel.dart';
import 'package:quotesquiz/model/qutoesmodel.dart';
import 'package:quotesquiz/services/api_service.dart';

final getQuotesListNotifier = FutureProvider<QuotesModel>((ref) async {
  return await ref.read(api_provider).getquotesquiz();
});






