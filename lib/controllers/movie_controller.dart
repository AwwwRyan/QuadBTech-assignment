import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

class MovieController {
  final String baseUrl = 'https://api.tvmaze.com';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/search/shows?q=all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Movie.fromJson(json['show'])).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/shows?q=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Movie.fromJson(json['show'])).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<List<Movie>> getDefaultMovies() async {
    return await fetchMovies();
  }
} 