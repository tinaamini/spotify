import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../../data/models/music/allMusicModel.dart';
import '../../state/music/musicPlayer_state.dart';
import 'dart:async';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;
  List<MusicModel> currentMusicList = [];


  MusicPlayerCubit() : super(MusicPlayerState.initial()) {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((playerState) {
      if (!isClosed) {
        print("Player state: ${playerState.processingState}");
        if (playerState.processingState == ProcessingState.completed) {
          if (state.isRepeating) {
            print("Repeating current music");
            _audioPlayer.seek(Duration.zero);
            _audioPlayer.play();
          } else {
            print("Music completed, playing next");
            playNext();
          }
        }
      }
    });
  }

  Future<void> loadMusic(MusicModel music,List<MusicModel> musicList) async {
    print("Loading music: ${music.name}, URL: ${music.audioUrl}");
    print("Received music list length: ${musicList.length}");
    currentMusicList = musicList;
    print("Current music list length after assignment: ${currentMusicList.length}");
    emit(state.copyWith(isLoading: true, music: music, error: null));
    try {
      await _audioPlayer.setUrl(music.audioUrl);
      print("Audio URL set successfully");


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
      print("Music started playing");

      if (!isClosed) {
        emit(state.copyWith(isPlaying: true, isLoading: false));
      }
    } catch (e) {
      print("Error loading audio: $e");
      if (!isClosed) {
        emit(state.copyWith(isLoading: false,isPlaying: false, error: 'Error loading audio: $e'));
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

  void playNext() {
    print("playNext called, current music list length: ${currentMusicList.length}");
    if (currentMusicList.isEmpty || state.music == null) {
      print("No music list or current music is null");
      emit(state.copyWith(isPlaying: false, error: "No music to play next"));
      return;
    }

    try {
      if (_audioPlayer.playing) {
        print("Stopping current music before playing next");
        _audioPlayer.pause();
        _audioPlayer.stop();
      }
    } catch (e) {
      print("Error stopping player: $e");
    }

    MusicModel nextMusic;
    if (state.isShuffling) {
      final random = Random();
      nextMusic = currentMusicList[random.nextInt(currentMusicList.length)];
      while (nextMusic.id == state.music!.id && currentMusicList.length > 1) {
        nextMusic = currentMusicList[random.nextInt(currentMusicList.length)];
      }
    } else {
      final currentIndex = currentMusicList.indexWhere((m) => m.id == state.music!.id);
      if (currentIndex == -1) {
        emit(state.copyWith(isPlaying: false, error: "Current music not found"));
        return;
      }
      if (currentIndex < currentMusicList.length - 1) {
        nextMusic = currentMusicList[currentIndex + 1];
      } else {
        nextMusic = currentMusicList[0];
      }
    }
    loadMusic(nextMusic, currentMusicList);
  }

  void playPrevious() {
    print("playPrevious called, current music list length: ${currentMusicList.length}");
    if (currentMusicList.isEmpty || state.music == null) {
      emit(state.copyWith(isPlaying: false, error: "No music to play previous"));
      return;
    }

    try {
      if (_audioPlayer.playing) {
        _audioPlayer.pause();
        _audioPlayer.stop();
      }
    } catch (e) {
      print("Error stopping player: $e");
    }

    MusicModel previousMusic;
    if (state.isShuffling) {
      final random = Random();
      previousMusic = currentMusicList[random.nextInt(currentMusicList.length)];
      while (previousMusic.id == state.music!.id && currentMusicList.length > 1) {
        previousMusic = currentMusicList[random.nextInt(currentMusicList.length)];
      }
    } else {
      final currentIndex = currentMusicList.indexWhere((m) => m.id == state.music!.id);
      final previousIndex = (currentIndex <= 0) ? currentMusicList.length - 1 : currentIndex - 1;
      previousMusic = currentMusicList[previousIndex];
    }
    loadMusic(previousMusic, currentMusicList);
  }

  void toggleShuffle() {
    final newShuffleState = !state.isShuffling;
    emit(state.copyWith(isShuffling: newShuffleState));
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}