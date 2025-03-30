import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/data/services/user/Auth.dart';
import 'package:spotify/logic/state/user/userProfile_state.dart';

import '../../../core/di/di.dart';
import '../../../data/models/user/userProfile.dart';
import '../../../data/services/tokenmanager.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit() : super(ProfileInitial());

  Future <void> loadProfile() async{
    emit(ProfileLoading());
    try{
      final token = await getIt<TokenManager>().getToken();
      if (token == null) {
        emit(ProfileError('No token found'));
        return;
      }
      final profileData = await getIt<AuthService>().profileUser(token);
      final userProfile = UserProfile.fromJson(profileData);
      emit(ProfileLoaded(userProfile));

    }catch(e){
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

}