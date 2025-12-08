abstract class BrowseEvent {}

class LoadBrowseEvent extends BrowseEvent {}

class ChangeGenreEvent extends BrowseEvent {
  final String genre;
  ChangeGenreEvent(this.genre);
}
