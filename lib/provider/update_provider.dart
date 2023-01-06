//
//
// import 'package:admin_dashboard/api/auth_admin_api.dart';
// import 'package:admin_dashboard/api/member_api.dart';
// import 'package:admin_dashboard/common/state.dart';
// import 'package:admin_dashboard/model/member_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
//
// class UpdateProvider with ChangeNotifier{
//   UpdateProvider(){
//     fetchUpdateUserData();
//   }
//   late CurrentState _state;
//   MemberDataUpdate? _memberDataUpdate;
//
//   MemberDataUpdate? get memberDataUpdate => _memberDataUpdate;
//   CurrentState get state => _state;
//
//   fetchUpdateUserData() async {
//     _state = CurrentState.isLoading;
//     notifyListeners();
//     try{
//       _memberDataUpdate = await getUserDataUpdate(auth.currentUser!.uid);
//       if(_memberDataUpdate != null){
//         _state = CurrentState.isSuccess;
//         notifyListeners();
//       }
//     }catch(e){
//       _state = CurrentState.isError;
//       notifyListeners();
//     }
//   }
//
// //
//
// }
