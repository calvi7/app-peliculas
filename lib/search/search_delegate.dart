import 'package:flutter/material.dart';
import 'package:peliculas/search/widgets/movie_query_builder.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Text('buildActions'),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return MovieQueryBuilder(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return MovieQueryBuilder(query: query);
  }
}

class NoDataFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Center(
        child: Column(
          children: [
            Text("No se hallaron coincidencias."),
            //TODO se puede agregar alguna imagen
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
