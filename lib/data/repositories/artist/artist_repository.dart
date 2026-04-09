import '../../../model/artist/artist.dart';
 

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();
  Future<List<Artist>> fetchArtistsCatch({bool forceFetch = false});
  Future<Artist?> fetchArtistById(String id);
}
