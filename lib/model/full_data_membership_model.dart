//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Membership {
//   late String id;
//   late String place;
//   late String startDate;
//   late String endDate;
//   late String name;
//   late String gender;
//   late String address;
//   late String phoneNumber;
//   late int age;
//   late int payment;
//
//   Membership.fromObject(DocumentSnapshot<Map<String, dynamic>> data) {
//     id = data.id;
//     place = data['place'];
//     startDate = data['startDate'];
//     endDate = data['endDate'];
//     name = data['name'];
//     gender = data['gender'];
//     address = data['address'];
//     phoneNumber = data['phoneNumber'];
//     age = data['age'];
//     payment = data['payment'];
//   }
// }