import 'package:admin_dashboard/api/member_api.dart';
import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/model/member_model.dart';
import 'package:flutter/widgets.dart';

class MemberProvider with ChangeNotifier{
  MemberProvider(){
    fetchMemberList();
  }
  bool _searchState = false;
  late CurrentState _state;
  List<MemberData> _memberList = [];

  bool get searchState => _searchState;
  CurrentState get state => _state;
  List<MemberData> get memberList => _memberList;

  fetchMemberList() async{
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final memberGymList = await filterDataByActive();
      if(memberGymList.isNotEmpty){
        _state = CurrentState.hasData;
        _memberList = memberGymList;
        notifyListeners();
      }else if(memberGymList.isEmpty){
        _state = CurrentState.noData;
        notifyListeners();
      }
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
      print(e);
    }
  }

  searchMemberGymData(String name) async{
    _searchState = true;
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final memberGymList = await getSearchedMemberData(name);
      if(memberGymList.isNotEmpty){
        _state = CurrentState.hasData;
        _memberList = memberGymList;
        notifyListeners();
      }
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }



  Future<String> getUserDataUpdate(String name, int age,
      String gender, String address, String phoneNumber, String memberId) async{
    final result = await updateDataUser(
      name,
      age,
      gender,
      address,
      phoneNumber,
      memberId,
    );
    fetchMemberList();
    return result;
  }

  Future getUserDataDelete(String memberId) async {
      final result = await deleteDataUser(memberId);
      fetchMemberList();
      return result;
  }
}



