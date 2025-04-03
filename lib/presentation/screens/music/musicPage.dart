import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import 'package:spotify/presentation/widgets/Custom_music_player.dart';
import 'package:spotify/core/di/di.dart';
import 'package:spotify/data/models/music/allMusicModel.dart';
import 'package:spotify/data/models/music/artistmodel.dart';
import 'package:spotify/data/services/music/musicServer.dart';
import 'package:spotify/logic/cubit/music/allMusic_cubit.dart';
import 'package:spotify/logic/cubit/music/musicPlayer_cubit.dart';
import 'package:spotify/logic/state/music/allMusic_State.dart';
import 'package:spotify/logic/state/music/musicPlayer_state.dart';
import 'package:spotify/routes/routs_name.dart';
import '../../../data/services/tokenmanager.dart';
import '../../widgets/customButtonBack.dart';
import '../../widgets/top_btns.dart';

class Musicpage extends StatelessWidget {
  final MusicModel music;
  final ArtistModel artist;

  const Musicpage({super.key, required this.music, required this.artist});

  static const String lyrics = '''
Sleepin', you're on your tippy toes
Creepin' around like no one knows
Think you're so criminal
Bruises on both my knees for you
Don't say thank you or please
I do what I want when I'm wanting to
My soul? So cynical
  ''';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AllMusicCubit(getIt<MusicServer>())..fetchMusics(),
            ),
            BlocProvider(
              create: (context) => MusicPlayerCubit()..loadMusic(music),
            ),
          ],
          child: BlocListener<AllMusicCubit, AllMusicState>(
            listener: (context, state) {
              if (state is ErrorMusic && state.isTokenInvalid) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("توکن شما منقضی شده است. لطفاً دوباره وارد شوید.")),
                );
                getIt<TokenManager>().clearToken();
                context.goNamed(RouteName.singIn);
              }
            },
            child: BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
              builder: (context, state) {
                return state.showLyrics
                    ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(music.coverUrl),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.dstATop,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 25.w,
                            horizontal: 20.w,
                          ),
                          child: TopBtns(
                            ontap: () {
                              context.goNamed(
                                RouteName.musicPage,
                                extra: {'music': music, 'artist': artist},
                              );
                            },
                            text: music.name,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100.w,
                        left: 40.w,
                        right: 0,
                        child: Container(
                          height: 540.w,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " ( Verse 1 )",
                                  style: AppTextStyle.TextBold.copyWith(fontSize: 15.w),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25.w, top: 20.w),
                                  child: Text(
                                    lyrics,
                                    style: AppTextStyle.Textlight.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  " ( Verse 2 )",
                                  style: AppTextStyle.TextBold.copyWith(fontSize: 15.w),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25.w, top: 20.w),
                                  child: Text(
                                    lyrics,
                                    style: AppTextStyle.Textlight.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: AppColor.appBackgroundColor,
                          height: 220.w,
                          child: CustomMusicPlayer(music: music, artist: artist),
                        ),
                      ),
                    ],
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackPage(
                            onTap: () {
                              context.go('/MainScreen?index=0');
                            },
                          ),
                          Text(
                            "Now Playing",
                            style: AppTextStyle.TextBold.copyWith(fontSize: 18.w),
                          ),
                          Icon(Icons.more_vert, color: AppColor.solidWhite),
                        ],
                      ),
                      Expanded(
                        child: CustomMusicPlayer(music: music, artist: artist),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}