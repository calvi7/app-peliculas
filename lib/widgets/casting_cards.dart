import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 100,
            child: CupertinoActivityIndicator(color: Colors.black),
          );
        } else {
          final cast = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => _CastCard(
                actor: cast[index],
              ),
            ),
          );
        }
      },
    );
  }
}

// ignore: unused_element
class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 190,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            image: NetworkImage(actor.fullProfilePath),
            placeholder: AssetImage('assets/no-image.jpg'),
            height: 140,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 5),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 30),
          child: Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 5),
        Text(
          actor.character!,
          maxLines: 3,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
