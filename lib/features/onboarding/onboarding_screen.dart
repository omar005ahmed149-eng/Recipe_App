import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/features/auth/register/registerScreen.dart';
import '../../../services/local_storage.dart';
import '../../core/resources/assets_manger.dart';
import 'onboarding_item.dart';
import 'onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller =.new();
  int currentIndex = 0;

  final List<OnBoardingModel> pages = [
    OnBoardingModel(
      title: "Find Your Next Favorite recipe Here",
      subtitle: "Get access to a huge library of recipes to suit all tastes. You will surely like it.",
      image: AssetsManger.poster1,
    ),
    OnBoardingModel(
      title: "Discover recipes",
      subtitle: "Explore a vast collection of recipes in all ingredients and genres. Find your next favorite Food with ease.",
      image: AssetsManger.poster2,
    ),
    OnBoardingModel(
      title: "Explore All Food Genres",
      subtitle: "Discover recipes from every genre, in all available ingredients. Find something new and exciting to eat every day.",
      image: AssetsManger.poster3,
    ),
    OnBoardingModel(
      title: "Create Cook lists",
      subtitle: "Save recipes to your Cook list to keep track of what you want to Cook next. Enjoy Food in various ingredients and genres.",
      image: AssetsManger.poster4,
    ),
  ];

  void next() async {
    if (currentIndex == pages.length - 1) {
      await LocalStorage.setSeenOnBoarding();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Registerscreen()),
      );
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void back() {
    if (currentIndex > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, index) {
          if (index == 0) {
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(pages[index].image, fit: BoxFit.cover),
                ),

                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 40,
                  left: 24,
                  right: 24,
                  top: 400.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        pages[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManger.white,
                          fontStyle: GoogleFonts.inter().fontStyle,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      Text(
                        pages[index].subtitle??" ",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white70,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      ElevatedButton(
                        onPressed: next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManger.yellow,
                          minimumSize: Size(double.infinity, 55.sp),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: const Text(
                          "Explore Now",
                          style: TextStyle(color: ColorsManger.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return OnBoardingItem(
            model: pages[index],
            isLast: index == pages.length - 1,
            onNext: next,
            onBack: back,
          );
        },
      ),
    );
  }
}
