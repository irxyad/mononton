class Movie {
  String title;
  String popularity;
  String poster;
  String releaseDate;
  String vote;
  String voteCount;
  String overview;

  Movie({
    required this.title,
    required this.popularity,
    required this.poster,
    required this.releaseDate,
    required this.vote,
    required this.voteCount,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> dataMovies, int id) => Movie(
      title: dataMovies[id]['title'],
      popularity: dataMovies[id]['popularity'].toString(),
      poster: dataMovies[id]['poster_path'],
      releaseDate: dataMovies[id]['release_date'],
      vote: dataMovies[id]['vote_average'].toString(),
      voteCount: dataMovies[id]['vote_count'].toString(),
      overview: dataMovies[id]['overview']);
}
