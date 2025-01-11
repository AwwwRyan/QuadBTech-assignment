import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/HtmlToTextWidget.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    final DateTime premieredDate = DateTime.parse(movie.premiered);
    final DateFormat dateFormat = DateFormat('d\'th\' MMM, yyyy');
    final String formattedDate = dateFormat.format(premieredDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.grey.shade900, Colors.black],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      movie.image,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(width: 10),
                      if(movie.rating != null)
                      Row(
                        children: [
                          Text(
                            "Rating: ${movie.rating.toString()}",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),

                      Text(
                        '${movie.status} Seasons',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  HtmlToTextWidget(
                    htmlText: movie.summary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
