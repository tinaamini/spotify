import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/music/musicServer.dart';
import '../../state/music/allMusic_State.dart';
import '../../state/music/createMusic_state.dart';

class CreateMusicCubit extends Cubit <CreateMusicState>{
  final MusicServer musicService;
  CreateMusicCubit(this.musicService) : super(const CreateMusicInitial());


  Future<void> createMusic({
    required String name,
    required int artistId,
    required File audioFile,
    required File coverFile,
  }) async {
    emit(const CreateMusicLoading());

    try {
      final newMusic = await musicService.createMusic(
        name: name,
        artistId: artistId,
        audioFile: audioFile,
        coverFile: coverFile,
      );
      emit(const CreateMusicSuccess());
    } catch (e) {
      emit(CreateMusicError("Failed to upload music: $e"));    }
  }
}