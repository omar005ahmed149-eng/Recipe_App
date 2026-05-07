import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/bloc/auth/auth_cubit.dart';
import 'package:recipes/core/bloc/auth/auth_state.dart';
import 'package:recipes/core/theme/theme_manger.dart';
import 'package:recipes/core/resources/route_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/bloc/reciepes/reciepes_cubit.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final onBoarding = prefs.getBool('seenOnBoarding') ?? false;
  final recipesCubit = ReciepesCubit();
  final authCubit = AuthCubit(recipesCubit);
  await authCubit.bootstrapSession();

  runApp(Recipe_App(
    seenOnboarding: onBoarding,
    hasValidSession: authCubit.state.status == AuthStatus.authenticated,
    recipesCubit: recipesCubit,
    authCubit: authCubit,
  ));
}

class Recipe_App extends StatelessWidget {
  final bool seenOnboarding;
  final bool hasValidSession;
  final ReciepesCubit recipesCubit;
  final AuthCubit authCubit;
  const Recipe_App({
    super.key,
    required this.seenOnboarding,
    required this.hasValidSession,
    required this.recipesCubit,
    required this.authCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: recipesCubit),
        BlocProvider.value(value: authCubit),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(430, 932),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: seenOnboarding == true
                ? (hasValidSession
                    ? RoutesManger.mainlayout
                    : RoutesManger.login)
                : RoutesManger.onBoarding,
            onGenerateRoute: RoutesManger.generateRoutes,
            darkTheme: ThemeManger().darkTheme,
            themeMode: ThemeMode.dark,
          );
        },
      ),
    );
  }
}
