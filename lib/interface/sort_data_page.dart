import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/provider/membership_provider.dart';
import 'package:admin_dashboard/provider/sort_by_name_provider.dart';
import 'package:admin_dashboard/provider/sort_data_by_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>[
  'Select Category',
  'Sort by Expired Date',
  'Sort by name',
];

class SortDataPage extends StatefulWidget {
  const SortDataPage({Key? key}) : super(key: key);

  @override
  State<SortDataPage> createState() => _SortDataPageState();
}

class _SortDataPageState extends State<SortDataPage> {
  String items = list.first;
  String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400],
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(25.0)),
              child: DropdownButton<String>(
                value: items,
                borderRadius: BorderRadius.circular(20),
                icon: const Icon(Icons.arrow_downward),
                hint: Text('Sort by..'),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    items = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            items == list[1]
                ? Container(
                    child: ChangeNotifierProvider(
                      create: (context) => SortDataByDateProvider(),
                      child: Consumer<SortDataByDateProvider>(
                          builder: (context, snapshot, _) {
                        final sortData = snapshot.memberList;
                        var currentState = snapshot.state;
                        if (currentState == CurrentState.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (currentState == CurrentState.hasData) {
                          return ListView.builder(
                              itemCount: sortData.length,
                              controller: ScrollController(),
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[200]),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 80,
                                                child: Text(
                                                  '${sortData[i].name}'
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ChangeNotifierProvider(
                                                create: (context) =>
                                                    MembershipProvider(
                                                        membershipId:
                                                            sortData[i].id),
                                                child: Consumer<
                                                    MembershipProvider>(
                                                  builder:
                                                      (context, snapshot, _) {
                                                    if (snapshot.state ==
                                                        CurrentState.hasData) {
                                                      final membershipData =
                                                          snapshot.membership;
                                                      return Text(
                                                          'Berlaku Sampai   : ${membershipData.endDate}');
                                                    } else if(snapshot.state == CurrentState.noData) {
                                                      return Text(
                                                        "Data tidak tersedia",
                                                      );
                                                    } else {
                                                      return Text("Maaf Terjadi Eror");
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
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
                  )
                : items == list[2]
                    ? Container(
                        child: ChangeNotifierProvider(
                          create: (context) => SortByNameProvider(),
                          child: Consumer<SortByNameProvider>(
                              builder: (context, snapshot, _) {
                            final sortData = snapshot.memberList;
                            var currentState = snapshot.state;
                            if (currentState == CurrentState.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (currentState == CurrentState.hasData) {
                              return ListView.builder(
                                  itemCount: sortData.length,
                                  shrinkWrap: true,
                                  controller: ScrollController(),
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey[200]),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 80,
                                                    child: Text(
                                                      '${sortData[i].name}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ChangeNotifierProvider(
                                                    create: (context) =>
                                                        MembershipProvider(
                                                            membershipId:
                                                                sortData[i].id),
                                                    child: Consumer<
                                                        MembershipProvider>(
                                                      builder: (context,
                                                          snapshot, _) {
                                                        if (snapshot.state ==
                                                            CurrentState
                                                                .hasData) {
                                                          final membershipData =
                                                              snapshot
                                                                  .membership;
                                                          return Text(
                                                              'Berlaku Sampai   : ${membershipData.endDate}');
                                                        } else if(snapshot.state == CurrentState.noData) {
                                                          return Text(
                                                            "Data tidak tersedia",
                                                          );
                                                        }else {
                                                          return Text("Maaf Terjadi Eror");
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            size: 50,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
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
                      )
                    : Text('Select Category')
          ],
        ),
      ),
    );
  }
}
