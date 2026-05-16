import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';

import 'bloc/home_bloc.dart';
import 'Widgets/Bottom_Section.dart';
import 'Widgets/Top_section.dart';
import 'Widgets/Blurred_Background.dart';

class Hometab extends StatelessWidget {
  const Hometab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const _HomeTabView(),
    );
  }
}

class _HomeTabView extends StatefulWidget {
  const _HomeTabView();

  @override
  State<_HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<_HomeTabView>
    with SingleTickerProviderStateMixin {
  late final AnimationController animController;
  late final Animation<double> fadeAnimation;

  String prevUrl = '';

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    fadeAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
      animController.forward(from: 0).then((_) {
          if (mounted) {
            setState(() {
              prevUrl = state.currentBackgroundUrl;
            });
          }
        });
      },
      builder: (context, state) {
        final currentUrl = state.currentBackgroundUrl;
        return Scaffold(
          backgroundColor: ColorsManger.black,
          body: Stack(
            children: [
              BlurredBackground(
                prevUrl: prevUrl,
                currentUrl: currentUrl,
                animation: fadeAnimation,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x44000000),
                      Color(0x22000000),
                      Color(0x99000000),
                      Color(0xF2000000),
                    ],
                    stops: [0.0, 0.3, 0.65, 1.0],
                  ),
                ),
              ),
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: TopSection(activeIndex: state.activeIndex),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(20.r),
                      child: Image.asset(AssetsManger.cook),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BottomSection(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}