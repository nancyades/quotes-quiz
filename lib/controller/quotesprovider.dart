import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotesquiz/model/loginmodel.dart';
import 'package:quotesquiz/model/qutoesmodel.dart';
import 'package:quotesquiz/services/api_service.dart';

final getQuotesListNotifier = FutureProvider<QuotesModel>((ref) async {
  return await ref.read(api_provider).getquotesquiz();
});


final addPostUserNotifier =
StateNotifierProvider<AddPostUserProvider, AddPostUserState>((ref) {
  return AddPostUserProvider(ref);
});

class AddPostUserProvider extends StateNotifier<AddPostUserState> {
  Ref ref;

  AddPostUserProvider(this.ref)
      : super(AddPostUserState(false, const AsyncLoading(), 'initial'));

  adduser(String username, String password) async {
    state = _loading();
    final data = await ref.read(api_provider).createUser(username, password);

    if (data != null) {
      state = _dataState(data);
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddPostUserState _dataState(UserModel entity) {
    return AddPostUserState(false, AsyncData(entity), '');
  }

  AddPostUserState _loading() {
    print(state);
    return AddPostUserState(true, state.id, '');
  }

  AddPostUserState _errorState(String errMsg) {
    return AddPostUserState(false, state.id, errMsg);
  }

}


class AddPostUserState {
  bool isLoading;
  AsyncValue<UserModel> id;
  String error;

  AddPostUserState(this.isLoading,this.id, this.error);

}

