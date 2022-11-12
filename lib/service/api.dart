import 'dart:convert';
import 'package:http/http.dart' as http;
import '../token.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List> loadMoviesprefs() async {
  final prefs = await SharedPreferences.getInstance();
  List allData = [];
  if (prefs.containsKey('dataMovies')) {
    var getData = prefs.getString('dataMovies');
    allData = jsonDecode(getData!);
  } else {
    String url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$token&region=ID';
    var response = await http.get(Uri.parse(url));
    var decode = json.decode(response.body);
    if (response.statusCode == 200) {
      List<dynamic> result = (decode as Map<String, dynamic>)['results'];
      var saveData = jsonEncode(result);
      await prefs.setString('dataMovies', saveData);
    }
  }
  return allData;
}

Future<List> loadMovies() async {
  List allData = [];

  String url =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$token&region=ID';
  var response = await http.get(Uri.parse(url));
  var decode = json.decode(response.body);
  if (response.statusCode == 200) {
    List<dynamic> result = (decode as Map<String, dynamic>)['results'];
    allData = result;
  }
  return allData;
}

//
Future addWatchlist(List dataMovies, int index, List watchlist) async {
  final prefs = await SharedPreferences.getInstance();

  Map temp = {
    'title': dataMovies[index]['title'],
    'poster_path': dataMovies[index]['poster_path']
  };
  watchlist[index] = temp;
  var saveData = jsonEncode(watchlist);
  await prefs.setString('watchlist', saveData);
}

//
void clearPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

//
Future loadWatchlist(List dataMovies) async {
  List watchlist = [];
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('watchlist')) {
    var load = prefs.getString('watchlist');

    watchlist = jsonDecode(load!);
  } else {
    watchlist.length = dataMovies.length;
  }
  return watchlist;
}

//
Future removeWatchlist(List watchlist, int index) async {
  final prefs = await SharedPreferences.getInstance();
  watchlist.removeAt(index);
  var saveData = jsonEncode(watchlist);
  await prefs.setString('watchlist', saveData);
}
