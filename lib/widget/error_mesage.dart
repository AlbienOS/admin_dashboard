import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget{
  const ErrorMessage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error,
              size: 50, color: Theme.of(context).colorScheme.error
          ),
          Text(
            "Maaf, telah terjadi kesalahan.",
          ),
        ],
      ),
    );
  }

}