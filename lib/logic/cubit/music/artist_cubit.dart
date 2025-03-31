import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/music/artist.dart';
import '../../../data/services/music/musicServer.dart';
import '../../state/music/artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final MusicServer _musicServer;

  ArtistCubit(this._musicServer) : super(ArtistState());

  Future<void> fetchArtists({int skip = 0, int limit = 100}) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final artists = await _musicServer.getArtists(skip: skip, limit: limit);
      final uniqueArtists = artists.fold<Map<String, Artist>>({}, (map, artist) {
        map[artist.name] = artist;
        return map;
      })
          .values
          .toList();
      emit(state.copyWith(artists: uniqueArtists, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }






}