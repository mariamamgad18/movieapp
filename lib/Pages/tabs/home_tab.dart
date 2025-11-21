import 'package:flutter/material.dart';
import 'package:movieapp/utils/AppColors.dart';


class HomeTab extends StatelessWidget {
  final TextStyle headerStyle = TextStyle(
    fontFamily: 'DancingScript',
    fontSize: 30,
    color: Appcolors.whitekColor,
    fontWeight: FontWeight.bold,
  );

  final TextStyle ratingStyle = TextStyle(
    color: Appcolors.whitekColor,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  final List<Map<String, String>> availableNow = [
    {
      "title": "1917",
      "image": "assets/images/1917.png",
      "rating": "7.7",
      "subtitle": "TIME IS THE ENEMY"
    },
    {
      "title": "Captain America",
      "image": "assets/images/captain.png",
      "rating": "7.7"
    },
    {
      "title": "Another Movie",
      "image": "assets/images/baby_driver.png",
      "rating": "7.7"
    }
  ];

  final List<Map<String, String>> actionMovies = [
    {
      "title": "Captain America",
      "image": "assets/images/captain2.png",
      "rating": "7.7"
    },
    {
      "title": "Batman",
      "image": "assets/images/dark_night.png",
      "rating": "7.7"
    },
    {
      "title": "Avengers",
      "image": "assets/images/black_widdw.png",
      "rating": "7.7"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Appcolors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  "Available Now",
                  style: headerStyle.copyWith(fontSize: 28),
                ),
              ),

              SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: availableNow.length,
                  itemBuilder: (context, index) {
                    final movie = availableNow[index];
                    return Container(
                      width: 220,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.blackColor,
                            blurRadius: 8,
                            offset: Offset(0, 5),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(movie["image"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Appcolors.blackColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    movie["rating"] ?? "N/A",
                                    style: ratingStyle,
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.star,
                                    color: Appcolors.yellowColor,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (movie["subtitle"] != null)
                            Positioned(
                              bottom: 14,
                              left: 10,
                              right: 10,
                              child: Text(
                                movie["subtitle"]!,
                                style: TextStyle(
                                  color: Appcolors.whitekColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text(
                  "Watch Now",
                  style: headerStyle.copyWith(fontSize: 32),
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Action",
                      style: TextStyle(
                        color: Appcolors.whitekColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See More →",
                        style: TextStyle(color: Appcolors.yellowColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:  EdgeInsets.symmetric(horizontal: 16),
                  itemCount: actionMovies.length,
                  itemBuilder: (context, index) {
                    final movie = actionMovies[index];
                    return Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(movie["image"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 6,
                            left: 6,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Appcolors.blackColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  Text(
                                    movie["rating"] ?? "N/A",
                                    style: ratingStyle.copyWith(fontSize: 10),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.star,
                                    color: Appcolors.yellowColor,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

