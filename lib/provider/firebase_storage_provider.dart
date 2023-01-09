import 'package:admin_dashboard/api/firebase_storage_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/model/firebase_storage_model.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageProvider with ChangeNotifier{
  FirebaseStorageProvider(){
    fetchFirebaseStorageList();
  }

  late CurrentState _state;
  List<FirebaseStorageFile> _firebaseStorageList = [];

  CurrentState get state => _state;
  List<FirebaseStorageFile> get firebaseStorageList => _firebaseStorageList;

  fetchFirebaseStorageList() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final storageList = await getDataFromStorage('files/');
      if(storageList.isNotEmpty){
        _state = CurrentState.hasData;
        _firebaseStorageList = storageList;
        notifyListeners();
      }else if(storageList.isEmpty){
        _state = CurrentState.noData;
        notifyListeners();
      }
    }catch(e){
      _state = CurrentState.isError;
      notifyListeners();
      print(e);
    }
  }
}