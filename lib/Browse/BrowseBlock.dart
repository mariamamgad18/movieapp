import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Browse/Browse_event.dart';
import 'package:movieapp/Browse/Browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final ApiManager api;

  BrowseBloc(this.api) : super(BrowseState.initial()) {
    on<LoadBrowseEvent>(_loadBrowseData);
    on<ChangeGenreEvent>(_changeGenre);
  }

  Future<void> _loadBrowseData(
      LoadBrowseEvent event, Emitter<BrowseState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final grouped = await api.getMoviesGroupedByGenre();

      final genres = grouped.keys.toList();

      emit(state.copyWith(
        moviesByGenre: grouped,
        genres: genres,
        selectedGenre: genres.first,
        filteredMovies: grouped[genres.first]!,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _changeGenre(ChangeGenreEvent event, Emitter<BrowseState> emit) {
    final selected = event.genre;
    final movies = state.moviesByGenre[selected] ?? [];

    emit(state.copyWith(
      selectedGenre: selected,
      filteredMovies: movies,
    ));
  }
}
