import '../../../data/models/music/allMusicModel.dart';

abstract class AllMusicState {
  const AllMusicState();
}

class InitialMusic extends AllMusicState {
  const InitialMusic();
}

class LoadingMusic extends AllMusicState {
  const LoadingMusic();
}

class LoadedMusic extends AllMusicState {
  final List<MusicModel> musics;

  const LoadedMusic(this.musics);
}

class ErrorMusic extends AllMusicState {
  final String message;
  final bool isTokenInvalid;
  const ErrorMusic(this.message,{this.isTokenInvalid = false});
}