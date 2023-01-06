import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget{
  static const routeName = '/ResponsiveLayout';
  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    required this.tabletBody,
    required this.dekstopBody,
  }) : super(key: key);

  final Widget mobileBody;
  final Widget tabletBody;
  final Widget dekstopBody;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < 500){
            return mobileBody;
          }else if(constraints.maxWidth < 1100){
            return tabletBody;
          }else {
            return dekstopBody;
          }
        });
  }

}