import 'package:admin_dashboard/interface/login_admin_page.dart';
import 'package:admin_dashboard/interface/unactive_member_page.dart';
import 'package:admin_dashboard/model/member_model.dart';
import 'package:admin_dashboard/model/membership_model.dart';
import 'package:admin_dashboard/provider/auth_admin_provider.dart';
import 'package:admin_dashboard/provider/member_provider.dart';
import 'package:admin_dashboard/provider/unactive_member_provider.dart';
import 'package:admin_dashboard/responsive/membership_detail.dart';
import 'package:admin_dashboard/responsive/dekstop_scaffold.dart';
import 'package:admin_dashboard/responsive/mobile_scaffold.dart';
import 'package:admin_dashboard/responsive/responsive_layout.dart';
import 'package:admin_dashboard/responsive/tablet_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthAdminProvider()),
      ChangeNotifierProvider(create: (context) => MemberProvider()),
      ChangeNotifierProvider(create: (context) => UnactiveMemberProvider()),
    ],
        child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Champions Fitness',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthAdminProvider>(builder: (context, snapshot, _){
        if(snapshot.adminData != null){
          return  ResponsiveLayout(
            mobileBody: MobileScaffold(),
            tabletBody: TabletScaffold(),
            dekstopBody: DesktopScaffold(),
          );
        }else {
          return LoginAdminPage();
        }
      }),
      routes: {
        LoginAdminPage.routeName: (context) => LoginAdminPage(),
        ResponsiveLayout.routeName: (context) => ResponsiveLayout(
            mobileBody: MobileScaffold(),
            tabletBody: TabletScaffold(),
            dekstopBody: DesktopScaffold(),
        ),
        MobileScaffold.routeName: (context) => MobileScaffold(),
        TabletScaffold.routeName : (context) => TabletScaffold(),
        DesktopScaffold.routeName: (context) => DesktopScaffold(),
        MembershipDekstop.routeName: (context) => MembershipDekstop(membershipId: ModalRoute.of(context)!.settings.arguments as String),
        UnactiveMemberPage.routeName: (context) => UnactiveMemberPage(),
      },
    );
  }
}
