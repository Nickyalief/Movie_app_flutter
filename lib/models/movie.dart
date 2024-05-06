class Movie {
  late int id;
  late String title;
  late double voteAverage;
  late String overview;
  late String posterPath;
  late String releaseDate;
  // late String trailerKey;

  Movie(
    this.id,
    this.title,
    this.voteAverage,
    this.overview,
    this.posterPath,
    this.releaseDate,
    // this.trailerKey,
  );

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    voteAverage = parsedJson['vote_average'] * 1.0;
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
    releaseDate = parsedJson['release_date'];
    // trailerKey = parsedJson['trailer_key'] ?? '';
  }

  get index => null;
}
