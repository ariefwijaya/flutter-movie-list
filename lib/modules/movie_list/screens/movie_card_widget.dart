
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieListCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? image;
  final String title;
  final String description;
  final String releaseDate;
  const MovieListCard({
    Key? key,
    required this.image,required this.title,required this.description,
    required this.releaseDate,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Row(children: [
          Container(
            margin: EdgeInsets.all(16),
            height: 95,
            width: 95,
            decoration: BoxDecoration(
                image: image==null?null:DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        CachedNetworkImageProvider(image!))),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 10),
                Text(description),
                SizedBox(height: 5),
                Text("Release Date: $releaseDate")
      
              ],
            ),
          ),
          SizedBox(width: 16)
        ]),
      ),
    );
  }
}
