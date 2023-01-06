import 'package:cloud_firestore/cloud_firestore.dart';

class AdminData{
  late String id;
  late String name;
  late String gender;
  late String address;
  late String phoneNumber;

  AdminData.fromObject(DocumentSnapshot<Map<String, dynamic>> adminData){
    id = adminData.id;
    name = adminData['name'];
    gender = adminData['gender'];
    address = adminData['address'];
    phoneNumber = adminData['phoneNumber'];
  }
}