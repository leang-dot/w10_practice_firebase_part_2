import '../../../model/songs/song.dart';

abstract class SongRepository {
  Future<List<Song>> fetchSongs();
  Future<void> likeSong(Song song);
  Future<Song?> fetchSongById(String id);
  Future<List<Song>> cacheFetchSongs({bool forceFetch = false});
}
