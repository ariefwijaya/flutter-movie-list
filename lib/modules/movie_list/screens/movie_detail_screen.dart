import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/modules/movie_list/models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel detail;
  const MovieDetailScreen({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(detail.title)),
      body: ListView(
        children: [
          Container(
            height: 195,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(detail.backdropPath!))),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(detail.title, style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 10),
                Text(detail.overview),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
               padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DetailCard(
                        title: "Release Date",
                        content:
                           detail.releaseDate??"",
                      ),
                    ),
                    Expanded(
                      child: DetailCard(
                        title: "Popularity",
                        content:
                            detail.popularity.toString(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DetailCard(
                        title: "Vote Average",
                        content:
                            detail.voteAverage.toString()
                      ),
                    ),
                    Expanded(
                      child: DetailCard(
                        title: "Vote Count",
                        content:
                            detail.voteCount.toString(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DetailCard(
                        title: "For Adult",
                        content:
                            detail.adult.toString()
                      ),
                    ),
                    Expanded(
                      child: DetailCard(
                        title: "ID",
                        content:
                            detail.id.toString(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Pretty JSON"),
Text(detail.toPrettyJson()),
              ],
            ),
          ),
          SizedBox(height: 15,)
        ],
      
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({Key? key, required this.title, required this.content})
      : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(content)
          ],
        ),
      ),
    );
  }
}
