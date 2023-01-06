
import 'package:admin_dashboard/model/admin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



Future<User?> login(String email, String password) async{
  try{
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }on FirebaseAuthException catch(e){
    if(e.code == 'user-not-found'){
      return null;
    }else if(e.code == 'wrong password'){
      return null;
    }
  }catch (e){
    return null;
  }
}

Future<AdminData?> getAdminData(String adminId) async{
  try{
    final adminData = await FirebaseFirestore.instance.collection('admin').doc(adminId).get();
    return AdminData.fromObject(adminData);
  }catch(e){
    return null;
  }
}

Future<User?> logout() async{
  await FirebaseAuth.instance.signOut();
}