import 'package:admin_dashboard/model/member_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<MemberData>> getMemberList() async{
  final snapshot = await FirebaseFirestore.instance.collection('users').get();
  List<MemberData> _memberDataList = [];
  _memberDataList =
      snapshot.docs.map((data) => MemberData.fromObject(data)).toList();
  return _memberDataList;
}

Future<List<MemberData>> getSearchedMemberData(String name) async{
  final snapshot = await FirebaseFirestore.instance.collection('users').get();
  final resultSearch = snapshot.docs.map((e){
    if(e.data()['name'].toString().toLowerCase().contains(name.toLowerCase(),
    )){
      return e;
    }
  }).toList();
  final List<MemberData> listSearchedMemberGym = [];
  for(var e in resultSearch){
    if(e != null){
      listSearchedMemberGym.add(MemberData.fromObject(e));
    }
  }
  return listSearchedMemberGym;
}



Future<String> updateDataUser(String name, int age,
    String gender, String address, String phoneNumber, String memberId) async {
  final users = FirebaseFirestore.instance
      .collection('users')
      .doc(memberId);
  await users.update(
    {
      'name': name,
      'age': age,
      'gender': gender,
      'address': address,
      'phoneNumber': phoneNumber
    },
  );
  return "success";
}

Future<String> deleteDataUser(String memberId) async{
  final user = FirebaseFirestore.instance
      .collection('users')
      .doc(memberId);
  await user.delete();
  return "success";
}

