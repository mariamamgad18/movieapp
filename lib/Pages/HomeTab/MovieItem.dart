import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppRouteNames.dart';

import '../../Utils/AppImages.dart';

class Movieitem extends StatelessWidget {
  final dynamic movie;
  final dynamic movies;

  const Movieitem({Key? key, this.movie, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic item = movie ?? movies;

    // safety: لو ما فيش item رجع Widget فاضي
    if (item == null) {
      return const SizedBox.shrink();
    }

    // صور ممكن تكون null
    final String imageUrl = (item.mediumCoverImage ??
        item.largeCoverImage ??
        item.smallCoverImage ??
        item.backgroundImage ??
        "")
        .toString();

    // rating ممكن يكون num أو string أو null
    double rating = 0.0;
    try {
      if (item.rating != null) {
        if (item.rating is num) {
          rating = (item.rating as num).toDouble();
        } else if (item.rating is String) {
          rating = double.tryParse(item.rating) ?? 0.0;
        }
      }
    } catch (_) {
      rating = 0.0;
    }

    // id كـ int أو num
    int id = 0;
    try {
      if (item.id != null) {
        if (item.id is int) id = item.id as int;
        else if (item.id is num) id = (item.id as num).toInt();
        else if (item.id is String) id = int.tryParse(item.id) ?? 0;
      }
    } catch (_) {
      id = 0;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Approutenames.MovieDeatils,
          arguments: id,
        );
      },
      child: Container(
        width: 170,
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: imageUrl.isNotEmpty
                ? CachedNetworkImageProvider(imageUrl)
                : const AssetImage('assets/images/placeholder.png') as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 60,
            height: 28,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(18, 19, 18, 0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 5),
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
