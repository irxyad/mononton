// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';

// class Movie {
//   String title;
//   double popularity;
//   String poster;
//   String releaseDate;
//   double vote;
//   double voteCount;

//   Movie({
//     required this.title,
//     required this.popularity,
//     required this.poster,
//     required this.releaseDate,
//     required this.vote,
//     required this.voteCount,
//   });

//   factory Movie.fromJson(Map<String, dynamic> object) => Movie(
//       title: object['title'],
//       popularity: object['popularity'],
//       poster: object['poster_path'],
//       releaseDate: object['release_date'],
//       vote: object['vote_average'],
//       voteCount: object['vote_count']);
// }

// class ImageMovie {
//   String urlimage;

//   ImageMovie({required this.urlimage});
// }

// class ImageKu extends StatelessWidget {
//   const ImageKu({super.key, required this.url});
//   final String url;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       width: 100,
//       child: Image.network(
//         url,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }

class Imageku {
  String url;

  Imageku({required this.url});
}
