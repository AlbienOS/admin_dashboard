
import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:flutter/material.dart';

class FilteringByGenderExpiredDataProvider with ChangeNotifier{
  FilteringByGenderExpiredDataProvider(){
    fetchDataExpiredByGender();
  }

  late CurrentState _state;
  late int _genderPria;
  late int _genderWanita;

  CurrentState get state => _state;
  int get genderPria => _genderPria;
  int get genderWanita => _genderWanita;

  fetchDataExpiredByGender() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final memberPria = await filterDataExpiredByGender('Pria');
      final memberWanita = await filterDataExpiredByGender('Wanita');
      _state = CurrentState.hasData;
      _genderPria = memberPria;
      _genderWanita = memberWanita;
      notifyListeners();
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}