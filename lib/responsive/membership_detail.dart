import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/constant.dart';
import 'package:admin_dashboard/helper/navigation.dart';
import 'package:admin_dashboard/provider/membership_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MembershipDekstop extends StatelessWidget {
  static const routeName = '/MembershipDekstop';

  const MembershipDekstop({
    Key? key,
    required this.membershipId,
  }) : super(key: key);

  final String membershipId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MembershipProvider>(
      create: (context) => MembershipProvider(membershipId: membershipId),
      child: Consumer<MembershipProvider>(builder: (context, snapshot, _) {
        var currentState = snapshot.state;
        if (currentState == CurrentState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (currentState == CurrentState.hasData) {
          final membershipData = snapshot.membership;
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: const Text(
                            'Membership Detail ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${membershipData.place}'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        child: Text('Start Date'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          ':  ${membershipData.startDate}'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        child: Text('End Date'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(':  ${membershipData.endDate}'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        child: Text('Price'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(NumberFormat.currency(
                                              locale: 'id',
                                              symbol: ':  RP ',
                                              decimalDigits: 0)
                                          .format(membershipData.payment)),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  // second half of page
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        // list of stuff
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
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
        } else {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: CircularProgressIndicator()));
        }
      }),
    );
  }
}
