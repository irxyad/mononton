import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataMovie = [];

  Future<List> getData() async {
    String token = '7516cf2841dabdc267462fe970d844cf';

    String url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$token&language=id-ID&page=1';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      List<dynamic> listMovies =
          (jsonObject as Map<String, dynamic>)['results'];
      dataMovie.add((listMovies));
      List<dynamic> hasil = (dataMovie)[0];
      setState(() {
        dataMovie = hasil;
      });
      return dataMovie;
    } else {
      throw 'e';
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String urlImage = 'https://image.tmdb.org/t/p/original/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataMovie.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                for (int i = 0; i < 20; i++)
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade400),
                    child: Column(
                      children: [
                        Image.network(
                          urlImage + dataMovie[i]['poster_path'],
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                        Text(dataMovie[i]['title']),
                        Text(dataMovie[i]['popularity'].toString()),
                        Text(dataMovie[i]['vote_average'].toString()),
                        Text(dataMovie[i]['vote_count'].toString()),
                        Text(dataMovie[i]['release_date']),
                        // Text(dataMovie[i].voteCount.toString()),
                        // Text(dataMovie[i].vote.toString()),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
