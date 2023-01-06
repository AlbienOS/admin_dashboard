import 'package:admin_dashboard/api/member_api.dart';
import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:flutter/material.dart';

class TotalUserDataProvider with ChangeNotifier{
  TotalUserDataProvider(){
    fetchTotalUser();
  }

  late CurrentState _state;
  late int _total;

  CurrentState get state => _state;
  int get total => _total;

  fetchTotalUser() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final totalUser = await totalDataActive();
      _state = CurrentState.hasData;
      _total = totalUser;
      notifyListeners();
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}