import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '8043646183d17ebc4a089883609f0729';
  String _baseUrl = 'api.themoviedb.org';
  String _lang = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String unencodedPath, [int page = 1]) async {
    var url = Uri.https(
      this._baseUrl,
      unencodedPath,
      {
        'api_key': this._apiKey,
        'language': this._lang,
        'page': '$page',
      },
    );

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) {
      print("No request was needed.");
      return movieCast[movieId]!;
    }

    print('Requesting cast data ...');

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');

    final movieCreditsResponse = MovieCreditsResponse.fromJson(jsonData);

    movieCast[movieId] = movieCreditsResponse.cast;

    return movieCreditsResponse.cast;
  }
}
