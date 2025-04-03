import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../../data/models/music/allMusicModel.dart';
import '../../state/music/musicPlayer_state.dart';
import 'dart:async'; // برای مدیریت استریم‌ها

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;

  MusicPlayerCubit() : super(MusicPlayerState.initial()) {

    _playerStateSubscription = _audioPlayer.playerStateStream.listen((playerState) {
      if (!isClosed) {
        if (playerState.processingState == ProcessingState.completed && state.isRepeating) {
          _audioPlayer.seek(Duration.zero);
          _audioPlayer.play();
        }
      }
    });
  }

  Future<void> loadMusic(MusicModel music) async {
    emit(state.copyWith(isLoading: true, music: music));
    try {
      await _audioPlayer.setUrl(music.audioUrl);


      _positionSubscription?.cancel();
      _durationSubscription?.cancel();


      _positionSubscription = _audioPlayer.positionStream.listen((position) {
        if (!isClosed) {
          emit(state.copyWith(
            position: position,
            duration: _audioPlayer.duration,
            isPlaying: _audioPlayer.playing,
            isLoading: false,
          ));
        }
      });


      _durationSubscription = _audioPlayer.durationStream.listen((duration) {
        if (!isClosed) {
          emit(state.copyWith(
            position: _audioPlayer.position,
            duration: duration,
            isPlaying: _audioPlayer.playing,
            isLoading: false,
          ));
        }
      });

      await _audioPlayer.play();

      if (!isClosed) {
        emit(state.copyWith(isPlaying: true, isLoading: false));
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, error: 'Error loading audio: $e'));
      }
    }
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
    if (!isClosed) {
      emit(state.copyWith(position: position));
    }
  }

  void play() {
    _audioPlayer.play();
    if (!isClosed) {
      emit(state.copyWith(isPlaying: true));
    }
  }

  void pause() {
    _audioPlayer.pause();
    if (!isClosed) {
      emit(state.copyWith(isPlaying: false));
    }
  }


  void toggleRepeat() {
    final newRepeatState = !state.isRepeating;
    _audioPlayer.setLoopMode(newRepeatState ? LoopMode.one : LoopMode.off);
    if (!isClosed) {
      emit(state.copyWith(isRepeating: newRepeatState));
    }
  }

  void toggleLyrics() {
    if (!isClosed) {
      emit(state.copyWith(showLyrics: !state.showLyrics));
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}