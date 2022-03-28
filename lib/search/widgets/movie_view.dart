import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieView extends StatelessWidget {
  final Movie movie;

  const MovieView({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        'details',
        arguments: movie,
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        padding: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: double.infinity,
                image: NetworkImage(movie.fullPosterImg),
                placeholder: AssetImage('assets/no-image.jpg'),
              ),
            ),
            SizedBox(width: 5),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width * 0.8),
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
