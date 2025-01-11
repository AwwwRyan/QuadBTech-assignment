import 'package:flutter/material.dart';
import 'package:movie_show/screens/details_screen.dart';
import 'package:movie_show/screens/home_screen.dart';
import 'package:movie_show/screens/search_screen.dart';
import 'package:movie_show/screens/splash_screen.dart';
import 'package:movie_show/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Explorer',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/details': (context) => DetailsScreen()
      },
    );
  }
}
