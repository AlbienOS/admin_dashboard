import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/provider/filtering_by_gender_provider.dart';
import 'package:admin_dashboard/provider/total_user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataRecap extends StatefulWidget {
  const DataRecap({Key? key}) : super(key: key);

  @override
  State<DataRecap> createState() => _DataRecapState();
}

class _DataRecapState extends State<DataRecap> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilteringByGenderProvider(),
        ),
        ChangeNotifierProvider(create: (context) => TotalUserDataProvider())
      ],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Column(
          children: [
            TotalDataRecap(),
            GenderRecap(),
          ],
        ),
      ),
    );
  }
}

class GenderRecap extends StatelessWidget {
  const GenderRecap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FilteringByGenderProvider>(
      builder: (context, snapshot, _) {
        var currentState = snapshot.state;
        if (currentState == CurrentState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (currentState == CurrentState.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 22.0),
                        child: Text('${snapshot.genderPria}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Member Pria',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 22.0),
                        child: Text('${snapshot.genderWanita}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Member Wanita',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ],
            ),
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
    );
  }
}

class TotalDataRecap extends StatelessWidget {
  const TotalDataRecap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Consumer<TotalUserDataProvider>(
        builder: (context, snapshot, _) {
          var currentState = snapshot.state;
          if (currentState == CurrentState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (currentState == CurrentState.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Center(
                            child: Text(
                              '${snapshot.total}',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                Text('Total Member',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    )),
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
      );
  }
}
