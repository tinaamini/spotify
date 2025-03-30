import '../../../data/models/music/allMusic.dart';

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
  final List<Music> musics;

  const LoadedMusic(this.musics);
}

class ErrorMusic extends AllMusicState {
  final String message;

  const ErrorMusic(this.message);
}