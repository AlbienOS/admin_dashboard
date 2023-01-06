import 'package:admin_dashboard/api/membership_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/model/membership_model.dart';
import 'package:flutter/material.dart';

class MembershipProvider with ChangeNotifier{
  final String membershipId;

  MembershipProvider({required this.membershipId}){
    _state = CurrentState.noData;
    fetchMembership();
  }

  late CurrentState _state;
  late Membership _membership;

  CurrentState get state => _state;
  Membership get membership => _membership;

  fetchMembership() async{
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final membershipData = await getMembership(membershipId);
      _state = CurrentState.hasData;
      _membership = membershipData;
      notifyListeners();
    }catch (e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}
