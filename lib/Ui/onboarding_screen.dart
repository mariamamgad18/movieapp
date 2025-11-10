import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:movieapp/Utils/AppImages.dart';

import '../Utils/AppRouteNames.dart';
import 'login/TrasparentButton.dart';
import 'login/YellowButton.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": Appimages.OnBoarding1,
      "title": "Find Your Next\nFavorite Movie Here",
      "subtitle": "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    },
    {
      "image": Appimages.OnBoarding2,
      "title": "Discover Movies",
      "subtitle": "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    },
    {
      "image": Appimages.OnBoarding3,
      "title": "Explore All Genres",
      "subtitle": "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    },
    {
      "image": Appimages.OnBoarding4,
      "title": "Create Watchlists",
      "subtitle": "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    },
    {
      "image": Appimages.OnBoarding5,
      "title": "Rate, Review, and Learn",
      "subtitle": "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    },
    {
      "image": Appimages.OnBoarding6,
      "title": "Start Watching Now",
      "subtitle": "You’re all set — enjoy the app!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
        itemBuilder: (context, index) {
          final data = onboardingData[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                data["image"]!,
                fit: BoxFit.cover,
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: BoxDecoration(
                    color: Appcolors.blackColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data["title"] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      if (data["subtitle"] != null)
                        Text(
                          data["subtitle"]!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,

                              fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 20),

                      if (index == 0) ...[
                        GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Yellowbutton(buttonText: "Explore Now"),
                        ),
                      ] else if (index == 1) ...[
                        GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Yellowbutton(buttonText: "Next"),
                        ),
                      ] else if (index >= 2 && index <= 4) ...[
                        GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Yellowbutton(buttonText: "Next"),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Trasparentbutton(buttonText: "Back"),
                        ),
                      ] else if (index == 5) ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, Approutenames.Login);
                          },
                          child: Yellowbutton(buttonText: "Finish"),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Trasparentbutton(buttonText: "Back"),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
