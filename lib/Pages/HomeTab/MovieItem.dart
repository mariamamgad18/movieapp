import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Ui/MovieDeatails/MovieDetailsScreen.dart';
import '../../Utils/AppImages.dart';
import '../../models/GetAllFavoritesMovies.dart';

class Movieitem extends StatelessWidget {
  final dynamic movie;
  final dynamic movies;
  final VoidCallback? onFavoriteChanged;

  const Movieitem({
    Key? key,
    this.movie,
    this.movies,
    this.onFavoriteChanged, // ← ضيفي هذا
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final dynamic item = movie ?? movies;

    if (item == null) {
      return const SizedBox.shrink();
    }

    // تحقق من نوع الكائن
    bool isDataType = item is Data; // افترض أن Data مستوردة هنا

    // الحصول على imageUrl بناءً على النوع
    final String imageUrl;
    if (isDataType) {
      imageUrl = item.imageURL ?? '';
    } else {
      // استخدم السطر الأصلي للكائنات الأخرى
      imageUrl = (item.mediumCoverImage ??
          item.largeCoverImage ??
          item.smallCoverImage ??
          item.backgroundImage ??
          "")
          .toString();
    }

    // الحصول على rating بناءً على النوع
    double rating = 0.0;
    try {
      if (isDataType) {
        rating = item.rating?.toDouble() ?? 0.0;
      } else {
        if (item.rating != null) {
          if (item.rating is num) {
            rating = (item.rating as num).toDouble();
          } else if (item.rating is String) {
            rating = double.tryParse(item.rating) ?? 0.0;
          }
        }
      }
    } catch (_) {
      rating = 0.0;
    }

    int id = 0;
    try {
      if (isDataType) {
        id = int.tryParse(item.movieId ?? '') ?? 0;
      } else {
        if (item.id != null) {
          if (item.id is int) id = item.id as int;
          else if (item.id is num) id = (item.id as num).toInt();
          else if (item.id is String) id = int.tryParse(item.id) ?? 0;
        }
      }
    } catch (_) {
      id = 0;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Moviedetailsscreen(
              movieId: id,
              onFavoriteChanged: onFavoriteChanged,
            ),
          ),
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