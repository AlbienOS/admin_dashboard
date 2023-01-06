import 'package:admin_dashboard/api/auth_admin_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/interface/login_admin_page.dart';
import 'package:admin_dashboard/provider/auth_admin_provider.dart';
import 'package:admin_dashboard/provider/membership_provider.dart';
import 'package:admin_dashboard/responsive/membership_detail.dart';
import 'package:admin_dashboard/widget/error_mesage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);


var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      Consumer<AuthAdminProvider>(
        builder: (context, snapshot, _){
          var currentState = snapshot.state;
          if(currentState == CurrentState.isLoading){
            return Center(child: CircularProgressIndicator());
          }else if(currentState == CurrentState.isSuccess){
            final adminData = snapshot.adminData;
            return DrawerHeader(
              child: Column(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 70,
                  ),
                  Text(
                    'Admin, ${adminData?.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }else {
            return ErrorMessage();
          }
        },
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text('D A S H B O A R D',
            style: TextStyle(color: Colors.grey),
          ),
          onTap: (){},
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.settings),
          title: Text('S E T T I N G S',),
          onTap: (){},
        ),
      ),
      Padding(
        padding: tilePadding,
        child: Consumer<MembershipProvider>(
          builder: (context, provider, child){
            return ListTile(
              leading: Icon(Icons.info),
              title: Text(
                'M E M B E R S H I P',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: (){
                Navigator.pushReplacementNamed(context, MembershipDekstop.routeName);
              },
            );
          }
        ),
      ),
      Padding(
        padding: tilePadding,
        child: Consumer<AuthAdminProvider>(
          builder: (context, provider, child){
            return ListTile(
              leading: Icon(Icons.logout),
              title : const Text(
                'L O G O U T',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Center(
                      child: Text(
                          'Konfirmasi'
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child:Text(
                          "BATAL",
                        ),
                      ),
                      TextButton(
                          onPressed: (){
                            logout();
                            Navigator.pushReplacementNamed(context, LoginAdminPage.routeName);
                          },
                          child: Text('LOGOUT'))
                    ],
                  );
                });

              },
            );
          },

        ),
      ),
    ],
  ),
);

