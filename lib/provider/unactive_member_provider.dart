
import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/model/member_model.dart';
import 'package:flutter/widgets.dart';
class UnactiveMemberProvider with ChangeNotifier{
  UnactiveMemberProvider(){
    fetchUnactiveMember();
  }

  late CurrentState _state;
  List<MemberData> _memberList = [];


  CurrentState get state => _state;
  List<MemberData> get memberList => _memberList;


  fetchUnactiveMember() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final memberGymList = await filterDataByExpired();
      if (memberGymList.isNotEmpty) {
        _state = CurrentState.hasData;
        _memberList = memberGymList;
        notifyListeners();
      } else if (memberGymList.isEmpty) {
        _state = CurrentState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = CurrentState.isError;
      print(e);
      notifyListeners();
    }
  }
}