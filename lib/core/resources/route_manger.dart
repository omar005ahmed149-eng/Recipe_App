import 'package:flutter/cupertino.dart';
import 'package:recipes/core/models/recipe_Model.dart';
import 'package:recipes/features/Tabs/Home/HomeTab.dart';
import 'package:recipes/features/Tabs/Profile/ProfileTab.dart';
import 'package:recipes/features/auth/forget_pass/forget_pass_screen.dart';
import 'package:recipes/features/auth/register/registerScreen.dart';
import 'package:recipes/features/auth/login/login_screen.dart';
import 'package:recipes/features/onboarding/onboarding_screen.dart';
import 'package:recipes/features/recipe_details/recipe_details_screen.dart';
import '../../features/Tabs/MainLayoutPage/MainLayout.dart';
import '../../features/Update_Profile/Update_Profile.dart';

abstract class RoutesManger {
  static const String login = '/login';
  static const String register = '/register';
  static const String updateProfile = '/updateProfile';
  static const String forgetPassProfile = '/forgetPassProfile';
  static const String mainlayout = '/mainlayout';
  static const String homescreen = '/homeScreen';
  static const String search = '/search';
  static const String browse = '/browse';
  static const String profile = '/profile';
  static const String onBoarding = '/onBoarding';
  static const String recipeDetails = '/recipeDetails';

  static Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return CupertinoPageRoute(builder: (_) => Registerscreen());
      case login:
        return CupertinoPageRoute(builder: (_) => LoginScreen());
      case forgetPassProfile:
        return CupertinoPageRoute(builder: (_) => ForgetPassScreen());
      case updateProfile:
        return CupertinoPageRoute(builder: (_) => const UpdateProfile());
      case mainlayout:
        return CupertinoPageRoute(builder: (_) => Mainlayout());
      case onBoarding:
        return CupertinoPageRoute(builder: (_) => const OnBoardingScreen());
      case homescreen:
        return CupertinoPageRoute(builder: (_) => Hometab());
      case profile:
        return CupertinoPageRoute(builder: (_) => const Profiletab());
      case recipeDetails:
        final recipe = settings.arguments as ReciepeModel;
        return CupertinoPageRoute(
            builder: (_) => recipeDetailsScreen(recipe: recipe));
      default:
        return null;
    }
  }
}
