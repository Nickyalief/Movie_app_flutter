import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/service/https_service.dart';
import 'package:flutter_application_1/pages/movie_detail.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animations/animations.dart';

// Constants for padding and shadow
const double kDefaultPadding = 20.0;
final BoxShadow kDefaultShadow = BoxShadow(
  color: Colors.black.withOpacity(0.1),
  spreadRadius: 2,
  blurRadius: 5,
  offset: Offset(0, 2),
);

class MovieList extends StatefulWidget {
  final String category;

  const MovieList({Key? key, required this.category}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int moviesCount = 0;
  List<Movie> movies = [];
  late HttpService service;

  @override
  void initState() {
    super.initState();
    service = HttpService();
    _initialize();
  }

  Future<void> _initialize() async {
    final List<Movie> fetchedMovies = await service.getPopularMovies();

    setState(() {
      movies = fetchedMovies ?? [];
      moviesCount = movies.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Ensure AppBar background color is set
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Your code here for what happens when the menu button is pressed
          },
        ),
        title: const Text(
          "MovieDiscover",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Your code here for what happens when the search button is pressed
            },
            icon: const Icon(Icons.search, color: Colors.black), // Replaced EvaIcons with Icons.search
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: moviesCount,
          crossAxisSpacing: kDefaultPadding,
          mainAxisSpacing: kDefaultPadding,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return OpenContainer(
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (context, action) => buildMovieCard(context, movie),
              openBuilder: (context, action) => MovieDetail(movie),
            );
          },
        ),
      ),
    );
  }

  Widget buildMovieCard(BuildContext context, Movie movie) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [kDefaultShadow],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${movie.voteAverage.toStringAsFixed(1)}/10',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
                SizedBox(height: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

