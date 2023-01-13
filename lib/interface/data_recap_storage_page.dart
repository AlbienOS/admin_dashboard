import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/provider/firebase_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataRecapeStorage extends StatefulWidget {
  const DataRecapeStorage({Key? key}) : super(key: key);

  @override
  State<DataRecapeStorage> createState() => _DataRecapeStorageState();
}

class _DataRecapeStorageState extends State<DataRecapeStorage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirebaseStorageProvider(),
      child: Consumer<FirebaseStorageProvider>(
        builder: (context, snapshot, _) {
          final storageData = snapshot.firebaseStorageList;
          var currentState = snapshot.state;
          if(currentState == CurrentState.isLoading){
            return const Center(child: CircularProgressIndicator());
          } else if(currentState == CurrentState.hasData){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Center(
                                child: Text( storageData.length.toString(),
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ),
                    Text('Total Image',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            );
          }else if (currentState == CurrentState.noData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Maaf Data Tidak Tersedia.',
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error,
                          size: 50, color: Theme.of(context).colorScheme.error),
                      Text(
                        "Maaf, terjadi error.",
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          },
      ),
    );
  }
}