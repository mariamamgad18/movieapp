import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/utils/AppColors.dart';
import '../Api/Api_Manager.dart';
import '../Browse/Browse_bloc.dart';
import '../Browse/Browse_event.dart';
import '../Browse/Browse_state.dart';


class BrowsePage extends StatelessWidget {

  final api = ApiManager();
  BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrowseBloc(api)..add(LoadBrowseEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Browse")),
        body: BlocBuilder<BrowseBloc, BrowseState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Genres Tabs
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: state.genres.map((genre) {
                      final selected = genre == state.selectedGenre;
                      return GestureDetector(
                        onTap: () {
                          context.read<BrowseBloc>().add(ChangeGenreEvent(genre));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Appcolors.yellowColor,width: 2,
                            ),
                            color: selected ? Appcolors.yellowColor:Appcolors.transparentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            genre,
                            style: TextStyle(
                              color: selected ? Appcolors.blackColor : Appcolors.yellowColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                //  Movies List
                Expanded(
                  child: GridView.builder(
                    itemCount:  state.moviesByGenre[state.selectedGenre]?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .60,
                    ),
                    itemBuilder: (context, i) {
                      final movie = state.filteredMovies[i];
                      return Column(
                        children: [
                          Image.network(
                            movie.mediumCoverImage ?? "",
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(Icons.error),
                          ),
                          SizedBox(height: 5),
                          Text(
                            movie.title ?? "No title",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
