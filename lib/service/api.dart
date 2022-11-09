import 'dart:convert';
import 'package:http/http.dart' as http;
import '../token.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List> getMovies(List dataMovies) async {
  String url =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$token&region=ID';
  var response = await http.get(Uri.parse(url));
  var decode = json.decode(response.body);
  if (response.statusCode == 200) {
    List<dynamic> result = (decode as Map<String, dynamic>)['results'];
    dataMovies = result;
  }
  return dataMovies;
}

Future<List> getDetailMovies(List detailMovies, int i) async {
  final prefs = await SharedPreferences.getInstance();
  String url = 'https://api.themoviedb.org/3/movie/$i?api_key=$token';
  var response = await http.get(Uri.parse(url));
  var decode = json.decode(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    detailMovies.add(map);
  }
  return detailMovies;
}

Future<List> getGenres(List movieGenres) async {
  String url =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$token&language=id-ID';
  var response = await http.get(Uri.parse(url));
  var decode = json.decode(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    movieGenres.add(map);
  }
  return movieGenres;
}
