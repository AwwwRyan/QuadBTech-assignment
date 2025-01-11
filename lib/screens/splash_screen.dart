import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/movie_controller.dart';
import '../models/movie.dart';
import '../widgets/textwidget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MovieController _movieController = MovieController();

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() async {
    try {
      List<Movie> movies = await _movieController.fetchMovies();
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: movies,
        );
      });
    } catch (e) {
      print('Failed to load movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Awryan',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 34, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Prime',
                  style: TextStyle(color: Colors.redAccent, fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ],
            ),

        ),
      ),
    );
  }
} 