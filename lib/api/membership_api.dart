import 'package:admin_dashboard/model/member_model.dart';
import 'package:admin_dashboard/model/membership_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';


Future<Membership> getMembership(String membershipId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(membershipId)
      .collection('membership')
      .doc('Champions')
      .get();
  Membership _membership;
  _membership =
      Membership.fromObject(snapshot);
  return _membership;
}



Future<List<MemberData>> filterDataByActive() async{

  final List<MemberData> _memberDataFilterList = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final docs = (await userCollectionReference.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
        .doc(id)
        .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isBefore(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      _memberDataFilterList.add(convert);
    }
  }
  return _memberDataFilterList;
}


Future<int> totalDataActive() async{
  final List<MemberData> _memberDataFilterList = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final docs = (await userCollectionReference.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
        .doc(id)
        .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isBefore(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      _memberDataFilterList.add(convert);
    }
  }
  return _memberDataFilterList.length;

}

Future<int> totalDataExpired() async{
  final List<MemberData> _memberDataFilterList = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final docs = (await userCollectionReference.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
        .doc(id)
        .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isAfter(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      _memberDataFilterList.add(convert);
    }
  }
  return _memberDataFilterList.length;

}

Future<int> filterDataByGender(String gender) async{
  final List<MemberData> _memberDataFilterList = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final docs = (await userCollectionReference.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
        .doc(id)
        .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isBefore(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      if(convert.gender == gender){
        _memberDataFilterList.add(convert);
      }
    }
  }
  return _memberDataFilterList.length;

}

Future<int> filterDataExpiredByGender(String gender) async{
  final List<MemberData> _memberDataFilterList = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final docs = (await userCollectionReference.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
        .doc(id)
        .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isAfter(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      if(convert.gender == gender){
        _memberDataFilterList.add(convert);
      }
    }
  }
  return _memberDataFilterList.length;

}

Future<List<MemberData>> filterDataByExpired() async{

  final List<MemberData> _memberDataFilterList = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final docs = (await userCollectionReference.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
    .doc(id)
    .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isAfter(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      _memberDataFilterList.add(convert);
    }
  }
  return _memberDataFilterList;
}

Future<List<MemberData>> sortByDate() async {
  final List<Tuple2<MemberData, DateTime>> _compareData = [];
  final List<MemberData> _memberSortData = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final docs = (await userCollectionReference.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
        .doc(id)
        .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isBefore(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      _compareData.add(Tuple2(convert, date));
    }
  }
  _compareData.sort((a, b) => a.item2.compareTo(b.item2));
  for(var i in _compareData){
    _memberSortData.add(i.item1);
  }
  return _memberSortData;
}


Future<List<MemberData>> sortByNameDescending() async{

  final List<MemberData> _memberDataFilterList = [];

  final userCollectionReference = FirebaseFirestore.instance
      .collection('users');
  final userCollectionReferenceSortByByName = userCollectionReference
      .orderBy('name', descending: false);
  final docs = (await userCollectionReferenceSortByByName.get()).docs;
  for (var doc in docs) {
    final id = doc.id;
    final membershipReference = await userCollectionReference
        .doc(id)
        .collection('membership').get();

    String endDate = membershipReference.docs[0].get('endDate');
    DateTime date = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    if(now.isBefore(date)){
      final memberFilter = await userCollectionReference.doc(id).get();
      final convert = MemberData.fromObjectDocumentSnapshot(memberFilter);
      _memberDataFilterList.add(convert);
    }
  }
  return _memberDataFilterList;
}

