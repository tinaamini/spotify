import '../../../data/models/music/allMusicModel.dart';

class MusicPlayerState {
  final bool isLoading;
  final bool isPlaying;
  final MusicModel? music;
  final Duration position;
  final Duration? duration;
  final String? error;
  final bool showLyrics;
  final bool isRepeating;

  MusicPlayerState({
    required this.isLoading,
    required this.isPlaying,
    required this.position,
    this.duration,
    this.music,
    this.error,
    this.showLyrics = false,
    required this.isRepeating,
  });

  factory MusicPlayerState.initial() => MusicPlayerState(
    isLoading: false,
    isPlaying: false,
    music: null,
    error: null,
    position: Duration.zero,
    showLyrics:false,
    isRepeating: false,

  );

  MusicPlayerState copyWith({
    bool? isLoading,
    bool? isPlaying,
    MusicModel? music,
    Duration? position,
    Duration? duration,
    bool? isRepeating,
    String? error,
    bool? showLyrics,
  }) {
    return MusicPlayerState(
      isLoading: isLoading ?? this.isLoading,
      isPlaying: isPlaying ?? this.isPlaying,
      music: music ?? this.music,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      error: error ?? this.error,
      showLyrics: showLyrics ?? this.showLyrics,
      isRepeating: isRepeating ?? this.isRepeating,
    );
  }
}