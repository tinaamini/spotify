abstract class CreateMusicState {
  const CreateMusicState();
}

class CreateMusicInitial extends CreateMusicState {
  const CreateMusicInitial();
}

class CreateMusicLoading extends CreateMusicState {
  const CreateMusicLoading();
}

class CreateMusicSuccess extends CreateMusicState {
  const CreateMusicSuccess();
}

class CreateMusicError extends CreateMusicState {
  final String message;

  const CreateMusicError(this.message);
}