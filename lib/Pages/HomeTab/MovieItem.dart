import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppRouteNames.dart';

import '../../Utils/AppImages.dart';
import '../../models/movies_response.dart';

class Movieitem extends StatelessWidget {
  final Movies movies;

  const Movieitem({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(
          Approutenames.MovieDeatils,
          arguments: movies.id,
        );
      },
      child: Container(
        width: 170,
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              movies.mediumCoverImage ?? movies.largeCoverImage ?? "",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 60,
            height: 28,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(18, 19, 18, 0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movies.rating?.toString() ?? "0.0",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 5),
                Image.asset(
                  Appimages.star,
                  width: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
