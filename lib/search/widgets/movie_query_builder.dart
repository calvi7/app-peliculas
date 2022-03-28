import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/search/widgets/movie_view.dart';
import 'package:provider/provider.dart';

class MovieQueryBuilder extends StatelessWidget {
  const MovieQueryBuilder({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: FutureBuilder(
        future: moviesProvider.searchMovies(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return NoDataFound();
          }
          final searchResults = snapshot.data!;
          return Container(
            width: double.infinity,
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (_, index) => MovieView(
                movie: searchResults[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
