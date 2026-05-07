import 'package:flutter/material.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/features/Tabs/MainLayoutPage/Widgets/Customized_BottomNavigationBar.dart';

class Mainlayout extends StatefulWidget {
  const Mainlayout({super.key});

  @override
  State<Mainlayout> createState() => _MainlayoutState();
}

class _MainlayoutState extends State<Mainlayout> {
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        extendBody: true,
          backgroundColor: ColorsManger.black,
          body:CustomizedBottomnavigationbar()
      );
    }

}
