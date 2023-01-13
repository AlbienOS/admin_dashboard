import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/constant.dart';
import 'package:admin_dashboard/helper/navigation.dart';
import 'package:admin_dashboard/interface/data_recap_storage_page.dart';
import 'package:admin_dashboard/interface/image_page.dart';
import 'package:admin_dashboard/provider/firebase_storage_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FirebaseStoragePage extends StatelessWidget {
  static const routeName = '/FirebaseStoragePage';

  const FirebaseStoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Navigation(),
            Expanded(
              flex: 2,
              child: ChangeNotifierProvider(
                create: (context) => FirebaseStorageProvider(),
                child: Consumer<FirebaseStorageProvider>(
                    builder: (context, snapshot, _) {
                  final storageData = snapshot.firebaseStorageList;
                  var currentState = snapshot.state;
                  if (currentState == CurrentState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (currentState == CurrentState.hasData) {
                    return Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: storageData.length,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => ImagePage(
                                                  file: storageData[i])));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Image.network(
                                                    storageData[i].url,
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 8.0,
                                                  ),
                                                  child: Text(
                                                    storageData[i].name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    ),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Center(
                                                                  child: Text(
                                                                    'Konfirmasi',
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      "BATAL",
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      try {
                                                                        final delete =
                                                                            await Provider.of<FirebaseStorageProvider>(context, listen: false).deleteDataStorage(storageData[i].name);
                                                                        if (delete ==
                                                                            "success") {
                                                                          const SnackBar(
                                                                            content:
                                                                                Text(
                                                                              "Hapus Berhasil",
                                                                            ),
                                                                          );
                                                                          Navigator.pushReplacementNamed(
                                                                              context,
                                                                              FirebaseStoragePage.routeName);
                                                                        }
                                                                      } catch (e) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          const SnackBar(
                                                                            content:
                                                                                Text(
                                                                              "Maaf terjadi kesalahan",
                                                                            ),
                                                                          ),
                                                                        );
                                                                        print(
                                                                            e);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      "HAPUS",
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    );
                  } else if (currentState == CurrentState.noData) {
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
                                  size: 50,
                                  color: Theme.of(context).colorScheme.error),
                              Text(
                                "Maaf, terjadi error.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  DataRecapeStorage(),
                  // list of stuff
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
