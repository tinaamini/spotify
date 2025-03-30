import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/music/musicServer.dart';
import '../../state/music/allMusic_cubit.dart';

class AllMusicCubit extends Cubit<AllMusicState>{
  final MusicServer musicService;
  AllMusicCubit(this.musicService) : super( InitialMusic());

  Future<void> fetchMusics({
    int? artistId,
    int skip = 0,
    int limit = 100,
  }) async {
    emit(const LoadingMusic());

    try {
      final musics = await musicService.getAllMusic(
        artistId: artistId,
        skip: skip,
        limit: limit,
      );
      final likedMusics = await musicService.getLikedMusic();
      for (var music in musics) {
        music.isLiked = likedMusics.any((liked) => liked.id == music.id);
      }
      emit(LoadedMusic(musics));
    } catch (e) {
      emit(ErrorMusic(e.toString()));
    }
  }
  void updateLikeStatus(int musicId, bool isLiked) {
    if (state is LoadedMusic) {
      final currentState = state as LoadedMusic;
      final musics = currentState.musics;
      final musicIndex = musics.indexWhere((music) => music.id == musicId);
      if (musicIndex != -1) {
        musics[musicIndex].isLiked = isLiked;
        emit(LoadedMusic(List.from(musics)));
      }
    }
  }
  Future<void> likeMusic(int musicId) async {
    if (state is LoadedMusic) {
      final currentState = state as LoadedMusic;
      final musics = currentState.musics;
      final musicIndex = musics.indexWhere((music) => music.id == musicId);

      if (musicIndex != -1 && !musics[musicIndex].isLiked) {
        try {
          await musicService.likeMusic(musicId);
          updateLikeStatus(musicId, true);
        } catch (e) {
          updateLikeStatus(musicId, false);
        }
      }
    }
  }

  Future<void> unlikeMusic(int musicId) async {
    if (state is LoadedMusic) {
      final currentState = state as LoadedMusic;
      final musics = currentState.musics;
      final musicIndex = musics.indexWhere((music) => music.id == musicId);

      if (musicIndex != -1 && musics[musicIndex].isLiked) {
        try {
          await musicService.unlikeMusic(musicId);
          updateLikeStatus(musicId, false);
        } catch (e) {
          updateLikeStatus(musicId, true);
        }
      }
    }
  }
}