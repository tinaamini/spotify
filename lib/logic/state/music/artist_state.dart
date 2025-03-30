import '../../../data/models/music/artist.dart';

class ArtistState {
  final List<Artist> artists;
  final bool isLoading;
  final String? error;

  ArtistState({
    this.artists = const [],
    this.isLoading = false,
    this.error,
  });

  ArtistState copyWith({
    List<Artist>? artists,
    bool? isLoading,
    String? error,
  }) {
    return ArtistState(
      artists: artists ?? this.artists,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}