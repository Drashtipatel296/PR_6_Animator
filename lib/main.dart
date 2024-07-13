import 'package:flutter/material.dart';
import 'package:pr_6_space_app/controller/data_provider.dart';
import 'package:pr_6_space_app/controller/like_provider.dart';
import 'package:pr_6_space_app/screens/favourite/like_screen.dart';
import 'package:pr_6_space_app/screens/home/home_screen.dart';
import 'package:pr_6_space_app/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PlanetProvider(),),
      ChangeNotifierProvider(create: (context) => LikeProvider(),),
    ],
      child: const SpaceApp(),
    ),);
}

class SpaceApp extends StatelessWidget {
  const SpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),
        '/home' : (context) => const HomeScreen(),
        '/fav' : (context) => const LikeScreen(),
      },
    );
  }
}
