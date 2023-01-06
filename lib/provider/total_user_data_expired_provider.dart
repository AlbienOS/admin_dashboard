
import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:flutter/foundation.dart';

class TotalUserDataExpiredProvider with ChangeNotifier{
  TotalUserDataExpiredProvider(){
    fetchTotalDataExpired();
  }

  late CurrentState _state;
  late int _total;

  CurrentState get state => _state;
  int get total => _total;

  fetchTotalDataExpired() async{
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final totalExpiredUser = await totalDataExpired();
      _state = CurrentState.hasData;
      _total = totalExpiredUser;
      notifyListeners();
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}