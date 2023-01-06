

import 'package:admin_dashboard/api/auth_admin_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/model/admin_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthAdminProvider with ChangeNotifier{
  AuthAdminProvider(){
    fetchAdminData();
  }

  late CurrentState _state;
  AdminData? _adminData;

  CurrentState get state => _state;
  AdminData? get adminData => _adminData;

  fetchAdminData() async{
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      FirebaseAuth auth = FirebaseAuth.instance;
      _adminData = await getAdminData(auth.currentUser!.uid);
      if(_adminData != null){
        _state = CurrentState.isSuccess;
        notifyListeners();
      }
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
  Future<User?> loginAdmin(String email, String password) async{
    final result = await login(email, password);
    fetchAdminData();
    return result;
  }

}


