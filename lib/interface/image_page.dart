import 'package:admin_dashboard/model/firebase_storage_model.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget{
  static const routeName = '/ImagePage';
  final FirebaseStorageFile file;
  const ImagePage({Key? key, required this.file})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Image.network(
              file.url,
              height: 500,
              width: 500,
            ),
          ),
        ],
      ),
    );
  }

}