import 'package:flutter/material.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/features/Tabs/Profile/Widgets/top_section.dart';
import 'package:recipes/features/Tabs/Profile/Widgets/Bottom_Section.dart';

class Profiletab extends StatefulWidget {
  const Profiletab({super.key});

  @override
  State<Profiletab> createState() => _ProfiletabState();
}

class _ProfiletabState extends State<Profiletab> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.black,
      body: SafeArea(
        child: Column(
          children: [

            TopSection(
              selectedTab: selectedTab,
              onTabChanged: (index) => setState(() => selectedTab = index),
            ),

            Container(
              height: 1,
              color: const Color(0xFF2A2A2A),
            ),

            Expanded(
              child: BottomSection(selectedTab: selectedTab),
            ),
          ],
        ),
      ),
    );
  }
}
