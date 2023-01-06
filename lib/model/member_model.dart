import 'package:cloud_firestore/cloud_firestore.dart';

class MemberData{
  late String id;
  late String name;
  late String gender;
  late String address;
  late String phoneNumber;
  late int age;

  MemberData.fromObject(QueryDocumentSnapshot<Map<String, dynamic>> data){
    id = data.id;
    name = data['name'];
    gender = data['gender'];
    address = data['address'];
    phoneNumber = data['phoneNumber'];
    age = data['age'];
  }

  MemberData.fromObjectDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> data){
    id = data.id;
    name = data['name'];
    gender = data['gender'];
    address = data['address'];
    phoneNumber = data['phoneNumber'];
    age = data['age'];
  }
}

