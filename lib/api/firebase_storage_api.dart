import 'package:admin_dashboard/model/firebase_storage_model.dart';
import 'package:firebase_storage/firebase_storage.dart';


Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

Future<List<FirebaseStorageFile>> getDataFromStorage(String path) async{
  final ref = FirebaseStorage.instance.ref(path);
  final result = await ref.listAll();
  final urls = await _getDownloadLinks(result.items);
  return urls.asMap().map((index, url){
    final ref = result.items[index];
    final name = ref.name;
    final file  = FirebaseStorageFile(ref: ref, name: name, url: url);

    return MapEntry(index, file);
  }).values.toList();
}