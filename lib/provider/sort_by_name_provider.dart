

import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/model/member_model.dart';
import 'package:flutter/widgets.dart';

class SortByNameProvider with ChangeNotifier{
  SortByNameProvider(){
    fetchSortByName();
  }

  late CurrentState _state;
  List<MemberData> _memberList = [];

  CurrentState get state => _state;
  List<MemberData> get memberList => _memberList;

  fetchSortByName() async{
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final sortMemberData = await sortByNameDescending();
      if(sortMemberData.isNotEmpty){
        _state = CurrentState.hasData;
        _memberList = sortMemberData;
        notifyListeners();
      }else if(sortMemberData.isEmpty){
        _state = CurrentState.noData;
        notifyListeners();
      }
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}