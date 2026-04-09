import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'w-10-93bd2-default-rtdb.firebaseio.com',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }
  
  Future<void> likeSong(Song song) async {
    final Uri url = Uri.https(
      'w-10-93bd2-default-rtdb.firebaseio.com',
      '/songs/${song.id}.json',
    );

    try {
      final newLikes = song.like + 1;
      final response = await http.patch(
        url,
        body: jsonEncode({'likes': newLikes}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update likes');
      }
    } catch (e) {
      throw Exception('Failed to like the song: $e');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
