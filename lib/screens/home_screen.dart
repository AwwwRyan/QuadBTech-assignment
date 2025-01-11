import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/textwidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = ModalRoute.of(context)!.settings.arguments as List<Movie>;

    final Map<String, List<Movie>> moviesByGenre = {
      'All Movies': movies,
      'Drama': movies.where((movie) => movie.genres.contains('Drama')).toList(),
      'Comedy': movies.where((movie) => movie.genres.contains('Comedy')).toList(),
      'Sports': movies.where((movie) => movie.genres.contains('Sports')).toList(),
    };

    final Movie randomMovie = (movies..shuffle()).firstWhere((movie) => movie != movies.first);

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Awryan',
                style: TextStyle(color: CupertinoColors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Prime',
                style: TextStyle(color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Colors.grey.shade900, Colors.black],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search games, shows, movies...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      suffixIcon: Icon(Icons.mic, color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    style: TextStyle(color: Colors.white),
                    enabled: false,
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 16, right: 16, top: 8),
                  child: Opacity(
                    opacity: 0.7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        randomMovie.image,
                        width: double.infinity,
                        height: 450,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: Text(
                    randomMovie.title,
                    style: TextStyle(color: CupertinoColors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...moviesByGenre.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textWidget(
                      text: entry.key,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: entry.value.length,
                      itemBuilder: (context, index) {
                        final movie = entry.value[index];
                        return movie.thumbnail.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/details', arguments: movie);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      movie.thumbnail,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container();
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            Navigator.pushNamed(context, '/search');
          }
        },
      ),
    );
  }
} 