import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/provider/filtering_by_gender_expired_data_provider.dart';
import 'package:admin_dashboard/provider/total_user_data_expired_provider.dart';
import 'package:admin_dashboard/provider/total_user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DataExpiredRecap extends StatefulWidget{
  const DataExpiredRecap({Key? key}) : super(key: key);

  @override
  State<DataExpiredRecap> createState() => _DataRecapState();
}

class _DataRecapState extends State<DataExpiredRecap> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => FilteringByGenderExpiredDataProvider(),),
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

class GenderRecap extends StatelessWidget{
  const GenderRecap({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<FilteringByGenderExpiredDataProvider>(
      builder: (context, snapshot, _){
        var currentState = snapshot.state;
        if(currentState == CurrentState.isLoading){
          return const Center(child: CircularProgressIndicator());
        }else if(currentState == CurrentState.hasData){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
                        child: Text(
                            '${snapshot.genderPria}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, )
                        ),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Member Pria',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, )),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
                        child: Text(
                            '${snapshot.genderWanita}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, )
                        ),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Member Wanita',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, )),
                    ),
                  ],
                ),
              ],
            ),
          );
        }else if(currentState == CurrentState.noData){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Maaf Data Tidak Tersedia.',
              ),
            ],
          );
        }else{
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


class TotalDataRecap extends StatelessWidget{
  const TotalDataRecap({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TotalUserDataExpiredProvider(),
      child: Consumer<TotalUserDataExpiredProvider>(
        builder: (context, snapshot, _){
          var currentState = snapshot.state;
          if(currentState == CurrentState.isLoading){
            return const Center(child: CircularProgressIndicator());
          }else if(currentState == CurrentState.hasData){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                          child: Center(
                            child: Text(
                              '${snapshot.total}',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[400]),
                      ),

                    ],
                  ),
                ),
                Text('Total Member',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, )),
              ],
            );
          } else if (currentState == CurrentState.noData){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Maaf Data Tidak Tersedia.',
                ),
              ],
            );
          }else {
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

