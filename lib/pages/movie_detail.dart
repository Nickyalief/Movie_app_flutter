import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500';

  const MovieDetail(this.movie, {Key? key}) : super(key: key);

  Future<void> _launchTrailer(String trailerKey) async {
    if (trailerKey.isNotEmpty) {
      final url = 'https://www.youtube.com/watch?v=$trailerKey';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch trailer';
      }
    }
  }

 Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context); // Navigate back to previous screen
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String path = imgPath + movie.posterPath;
    final List<Widget> starIcons = _getStars(movie.voteAverage / 2);

    return Scaffold(
    
      // floatingActionButton: FloatingActionButton.extended(
      //   // onPressed: () {
      //   //   _launchTrailer(movie.trailerKey); // Assuming `trailerKey` exists in Movie model
      //   // },
      //   // icon: Icon(FontAwesomeIcons.youtube),
      //   label: Text('Watch Trailer'),
      //   backgroundColor: Colors.red,
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FadeInImage.memoryNetwork(
            image: path,
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context), // Added back button
                _buildMainPoster(path),
                const SizedBox(height: 16),
                _buildMovieInfo(context),
                const SizedBox(height: 16),
                _buildRatingAndRelease(starIcons),
                const SizedBox(height: 16),
                _buildDescription(movie.overview),
                const SizedBox(height: 16),
                _buildAdditionalInfo(),
                const SizedBox(height: 16),
                _buildWatchTrailerButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainPoster(String imagePath) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: FadeInImage.memoryNetwork(
          image: imagePath,
          fit: BoxFit.cover,
          placeholder: kTransparentImage,
        ),
      ),
    );
  }

  Widget _buildMovieInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: Theme.of(context).textTheme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        // Text(
        //   // movie.tagline ?? '',
        //   style: Theme.of(context).textTheme.subtitle1?.copyWith(
        //     fontWeight: FontWeight.w300,
        //     color: Colors.white70,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildRatingAndRelease(List<Widget> starIcons) {
    return Row(
      children: [
        Row(
          children: starIcons,
        ),
        const SizedBox(width: 8),
        Text(
          '${movie.voteAverage.toStringAsFixed(1)}/10',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'Release Date: ${movie.releaseDate}',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildAdditionalInfo() {
    // Additional information like cast, similar movies, etc., can be added here
    return Container();
  }

  Widget _buildWatchTrailerButton() {
    return InkWell(
      onTap: () {
        // Placeholder function for watching trailer
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              'Watch Trailer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

 

  List<Widget> _getStars(double number) {
    double halfStars = number % 1;
    int fullStars = number.toInt();
    List<Widget> stars = [];

    for (int i = 0; i < fullStars; i++) {
      stars.add(
        Icon(Icons.star, color: Colors.yellow),
      );
    }

    if (halfStars >= 0.5) {
      stars.add(
        Icon(Icons.star_half, color: Colors.yellow),
      );
    }

    return stars;
  }
}

