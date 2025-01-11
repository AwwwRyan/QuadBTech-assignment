import 'package:flutter/material.dart';
import 'package:movie_show/widgets/textwidget.dart';

import '../controllers/movie_controller.dart';
import '../models/movie.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MovieController movieController = MovieController();
  final TextEditingController searchController = TextEditingController();
  List<Movie> searchResults = [];

  @override
  void initState() {
    super.initState();
    loadDefaultMovies();
  }

  void loadDefaultMovies() async {
    final results = await movieController.getDefaultMovies();
    setState(() {
      searchResults = results;
    });
  }

  void searchMovies(String query) async {
    final results = await movieController.searchMovies(query);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: 'Search Movies'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search games, shows, movies...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  suffixIcon: Icon(Icons.mic, color: Colors.white),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                onChanged: searchMovies,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: searchController.text.isEmpty
                ? ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = searchResults[index];
                      if (movie.thumbnail.isEmpty) {
                        return Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          tileColor: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              movie.thumbnail,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            movie.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.play_arrow, color: Colors.white),
                            onPressed: () {
                              Navigator.pushNamed(context, '/details', arguments: movie);
                            },
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/details', arguments: movie);
                          },
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = searchResults[index];
                      if (movie.thumbnail.isEmpty) {
                        return Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/details', arguments: movie);
                          },
                          child: GridTile(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                movie.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: Text(
                                movie.title,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
} 