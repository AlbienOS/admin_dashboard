import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:flutter/widgets.dart';


class FilteringByGenderProvider with ChangeNotifier{
  FilteringByGenderProvider(){
    fetchMemberGender();

  }

  late CurrentState _state;
  late int _genderPria;
  late int _genderWanita;

  CurrentState get state => _state;
  int get genderPria => _genderPria;
  int get genderWanita => _genderWanita;

  fetchMemberGender() async{
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final memberPria = await filterDataByGender('Pria');
      final memberWanita = await filterDataByGender('Wanita');
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