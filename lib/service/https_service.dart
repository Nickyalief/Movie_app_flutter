import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/movie.dart';

class HttpService {
  final String apiKey = 'c514e231ec44ca45e8e3adb420b80254';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/';

  // Helper function to parse the response and handle errors
  List<Movie> _parseMovies(String responseBody) {
    final jsonResponse = json.decode(responseBody);
    if (jsonResponse['results'] is List) {
      final moviesMap = jsonResponse['results'] as List<dynamic>;
      return moviesMap.map((item) => Movie.fromJson(item)).toList();
    }
    throw FormatException("Unexpected response format");
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final uri = '${baseUrl}now_playing?api_key=$apiKey';
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == HttpStatus.ok) {
        print("Sukses mendapatkan film yang sedang tayang");
        return _parseMovies(response.body);
      } else {
        print("Gagal mendapatkan film yang sedang tayang: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Kesalahan saat mendapatkan film yang sedang tayang: $e");
      return [];
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final uri = '${baseUrl}top_rated?api_key=$apiKey';
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == HttpStatus.ok) {
        print("Sukses mendapatkan film berperingkat tinggi");
        return _parseMovies(response.body);
      } else {
        print("Gagal mendapatkan film berperingkat tinggi: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Kesalahan saat mendapatkan film berperingkat tinggi: $e");
      return [];
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final uri = '${baseUrl}popular?api_key=$apiKey';
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == HttpStatus.ok) {
        print("Sukses mendapatkan film populer");
        return _parseMovies(response.body);
      } else {
        print("Gagal mendapatkan film populer: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Kesalahan saat mendapatkan film populer: $e");
      return [];
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final uri = '${baseUrl}upcoming?api_key=$apiKey';
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == HttpStatus.ok) {
        print("Sukses mendapatkan film yang akan datang");
        return _parseMovies(response.body);
      } else {
        print("Gagal mendapatkan film yang akan datang: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Kesalahan saat mendapatkan film yang akan datang: $e");
      return [];
    }
  }
}
