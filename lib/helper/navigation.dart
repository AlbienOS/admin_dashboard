import 'package:admin_dashboard/api/auth_admin_api.dart';
import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/constant.dart';
import 'package:admin_dashboard/interface/login_admin_page.dart';
import 'package:admin_dashboard/interface/unactive_member_page.dart';
import 'package:admin_dashboard/provider/auth_admin_provider.dart';
import 'package:admin_dashboard/responsive/responsive_layout.dart';
import 'package:admin_dashboard/widget/error_mesage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../responsive/membership_detail.dart';

class Navigation extends StatelessWidget{
  static const routeName = "/Navigation";
  const Navigation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                onTap: (){
                  Navigator.pushReplacementNamed(context, ResponsiveLayout.routeName);
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: Icon(Icons.close),
                title: Text('U N A C T I V E',
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, UnactiveMemberPage.routeName);
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: Icon(Icons.logout),
                title : Text('L O G O U T',
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
              ),
            ),
          ],
        ),
      );
  }

}



