import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/music/musicServer.dart';
import '../../state/music/allMusic_cubit.dart';

class CreateMusicCubit extends Cubit <AllMusicState>{
  final MusicServer musicService;
  CreateMusicCubit(this.musicService) : super(const InitialMusic());


  Future<void> createMusic({
    required String name,
    required int artistId,
    required File audioFile,
    required File coverFile,
  }) async {
    emit(const LoadingMusic());

    try {
      final newMusic = await musicService.createMusic(
        name: name,
        artistId: artistId,
        audioFile: audioFile,
        coverFile: coverFile,
      );
      if (state is LoadedMusic) {
        final currentMusics = (state as LoadedMusic).musics;
        emit(LoadedMusic([...currentMusics, newMusic]));
      } else {
        emit(LoadedMusic([newMusic]));
      }
    } catch (e) {
      emit(ErrorMusic(e.toString()));
    }
  }
}