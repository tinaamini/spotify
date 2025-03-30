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
      emit(LoadedMusic(musics));
    } catch (e) {
      emit(ErrorMusic(e.toString()));
    }
  }
  Future<void> likeMusic(int musicId) async {
    if (state is LoadedMusic) {
      final currentState = state as LoadedMusic;
      final musics = currentState.musics;
      final musicIndex = musics.indexWhere((music) => music.id == musicId);

      if (musicIndex != -1 && !musics[musicIndex].isLiked) {
        try {

          musics[musicIndex].isLiked = true;
          emit(LoadedMusic(List.from(musics)));


          await musicService.likeMusic(musicId);
        } catch (e) {

          musics[musicIndex].isLiked = false;
          emit(LoadedMusic(List.from(musics)));
          emit(ErrorMusic(e.toString()));
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

          musics[musicIndex].isLiked = false;
          emit(LoadedMusic(List.from(musics)));


          await musicService.unlikeMusic(musicId);
        } catch (e) {

          musics[musicIndex].isLiked = true;
          emit(LoadedMusic(List.from(musics)));
          emit(ErrorMusic(e.toString()));
        }
      }
    }
  }
}