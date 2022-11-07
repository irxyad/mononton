import 'dart:convert';

// import 'package:mononton/models/movie.dart';
import 'package:http/http.dart' as http;

import '../token.dart';

// import '../token.dart';

// List dataMovie = [];
// List image = [];

// Future<List> getData(List data) async {
//   String url =
//       'https://api.themoviedb.org/3/movie/now_playing?api_key=$token&language=id-ID&page=1';
//   var response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     var jsonObject = json.decode(response.body);
//     List<dynamic> listMovies = (jsonObject as Map<String, dynamic>)['results'];
//     data.add((listMovies));
//     List<dynamic> hasil = (data)[0];

//     data = hasil;

//     return data;
//   } else {
//     throw 'e';
//   }
// }

// // GET IMAGE
// Future getImage(List movies, List dataImage) async {
//   image.clear();
//   String url =
//       'https://api.themoviedb.org/3/movie/now_playing?api_key=$token&language=id-ID&page=1';
//   var response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     var decode = json.decode(response.body);
//     List<dynamic> result = (decode as Map<String, dynamic>)['results'];

//     for (int i = 0; i < 20; i++) {
//       image.add(result[i]['poster_path']);
//     }

//     dataImage = image;

//     // movies.add((result));
//     // result.clear();
//     // List<dynamic> hasil = (dataMovie)[0];
//     // dataMovie = hasil;

//     // print(dataImage);
//     // print('-------------------');
//     // print(dataImage.length);

// //  if(hasil.isNotEmpty){

// //  }
//     return dataImage;
//   } else {
//     throw 'e';
//   }
// }

//     // for (int i = 0; i < 20; i++) {
//     //   String urlImage =
//     //       "https://image.tmdb.org/t/p/original${result[i]['poster_path']}";
//     //   if (image.length <= 20) {
//     //     image.add(urlImage);
//     //     // print("Sukses");
//     //   } else if (image.length >= 20) {
//     //     image.clear();
//     //     // print('Gagal');
//     //   }

//       // print('--------------------');
//       // print(image.length);

//       // if (image.length > 20) {
//       //   image.clear();
//       // } else {
//       //   image.add(urlImage);
//       // }
//       // print('https://image.tmdb.org/t/p/original${result[5]['poster_path']}');
//       // print(image.length);

//       // print(dataImage[2]);
// //       // print(result[i]['poster_path']);
// //     }
// //     return image;
// //     // dataMovie.add(result);
// //   }
// //   // return dataImage;
// // }

Future getImage(List dataImage) async {
  String url =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$token&language=en-US&region=ID';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var decode = json.decode(response.body);
    List<dynamic> result = (decode as Map<String, dynamic>)['results'];
    // dataImage.add(result);
    dataImage = result;
    // print(dataImage[1]['title']);
    // print('-------------------');
    // print(dataImage[0]['title']);
    //  'https://image.tmdb.org/t/p/original${dataImage[index]['poster_path']}'
    // return Imageku(
    //     url:
    //         'https://image.tmdb.org/t/p/original${dataImage[index]['poster_path']}');
    return dataImage;
    // return Movie(url: dataImage[])

    // for (int i = 0; i < result.length; i++) {
    //   image.add(result[i]['poster_path']);
    // }
    // dataImage.add(image); // setState(() {
    //   dataImage = image;
    // });

    // movies.add((result));
    // result.clear();
    // List<dynamic> hasil = (dataMovie)[0];
    // dataMovie = hasil;

    // print(dataImage);
    // print('-------------------');
    // print(dataImage.length);

//  if(hasil.isNotEmpty){

//  }
    // return dataImage;
  } else {
    throw 'e';
  }
}
