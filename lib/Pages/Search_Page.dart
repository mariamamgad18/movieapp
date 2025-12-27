import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/SearchCubit/SearchViewModel.dart';
import '../Cubit/SearchCubit/Search_States.dart';
import 'HomeTab/MovieItem.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final Searchviewmodel cubit;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = Searchviewmodel();
  }
  @override
  void dispose() {
    cubit.close();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: const Color(0xff0f0f0f),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              children: [
                /// Search Field
                TextField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.grey.shade800, // خلفية الحقل
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none, // لو عايزة من غير خط خارجي
                    ),
                  ),
                  onChanged: (value) {
                    cubit.MovieSearch(value.trim());
                  },
                ),


                const SizedBox(height: 20),

                Expanded(
                  child: BlocBuilder<Searchviewmodel, SearchStates>(
                    builder: (context, state) {
                      if (state is SearchLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is SearchEmptyState) {
                        return const Center(child: Text("No results"));
                      }

                      if (state is SearchErrorState) {
                        return Center(child: Text(state.errorMsg));
                      }

                      if (state is SearchSuccessState) {
                        return GridView.builder(
                          itemCount: state.searchResults.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .62,
                          ),
                          itemBuilder: (context, i) {
                            return Movieitem(
                              movies: state.searchResults[i],
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
