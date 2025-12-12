import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/SearchResponse.dart' as search_model;
import '../Api/Api_Manager.dart';
import 'HomeTab/MovieItem.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<search_model.SearchMovie> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  Timer? debounce;

  final ApiManager apiManager = ApiManager();

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await apiManager.searchMovies(query: query);
      final movies = response.data?.movies ?? [];

      setState(() {
        searchResults = movies;
      });
    } catch (e) {
      print("Search error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (debounce?.isActive ?? false) debounce!.cancel();
                          debounce = Timer(const Duration(milliseconds: 500), () {
                            performSearch(value.trim());
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 20),
          
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : searchResults.isEmpty
                    ? Center(
                  child: Image.asset(
                    "assets/images/search_tab.png",
                    width: 200,
                  ),
                )
                    :  Expanded(
                  child: GridView.builder(
                    itemCount: searchResults.length,
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, i) {
                      return Movieitem(movies: searchResults[i]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
