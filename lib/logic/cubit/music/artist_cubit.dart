import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/music/artistmodel.dart';
import '../../../data/services/music/musicServer.dart';
import '../../state/music/artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final MusicServer _musicServer;

  ArtistCubit(this._musicServer) : super(ArtistState());

  Future<void> fetchArtists({int skip = 0, int limit = 100}) async {
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, error: null));
    }
    try {
      final artists = await _musicServer.getArtists(skip: skip, limit: limit);
      final uniqueArtists = artists.fold<Map<String, ArtistModel>>({}, (map, artist) {
        map[artist.name] = artist;
        return map;
      }).values.toList();
      if (!isClosed) {
        emit(state.copyWith(artists: uniqueArtists, isLoading: false));
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }




}