import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import 'package:spotify/core/di/di.dart';
import 'package:spotify/data/models/music/allMusicModel.dart';
import 'package:spotify/data/models/music/artistmodel.dart';
import 'package:spotify/logic/cubit/music/musicPlayer_cubit.dart';
import 'package:spotify/logic/state/music/musicPlayer_state.dart';
import 'package:spotify/presentation/widgets/Custom_music_player.dart';
import 'package:spotify/routes/routs_name.dart';
import '../../widgets/customButtonBack.dart';
import '../../widgets/top_btns.dart';

class Musicpage extends StatelessWidget {
  final MusicModel initialMusic;
  final ArtistModel artist;
  final List<MusicModel> musicList;
  const Musicpage({
    super.key,
    required this.initialMusic,
    required this.artist,
    required this.musicList,
  });

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
    final musicPlayerCubit = getIt<MusicPlayerCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Loading initial music: ${initialMusic.name}, List length: ${musicList.length}");
      musicPlayerCubit.loadMusic(initialMusic, musicList);
    });

    return SafeArea(
      child: Scaffold(
        body: BlocProvider.value(
          value: musicPlayerCubit,
          child: BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
            builder: (context, state) {
              final currentMusic = state.music ?? initialMusic;

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
                          image: NetworkImage(currentMusic.coverUrl),
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
                              extra: {'music': currentMusic, 'artist': artist,'musicList': musicList,},
                            );
                          },
                          text: currentMusic.name,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100.w,
                      left: 40.w,
                      right: 0,
                      child: SizedBox(
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
                        child: CustomMusicPlayer(
                          initialMusic: currentMusic,
                          artist: artist,
                        ),
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
                      child: CustomMusicPlayer(
                        initialMusic: currentMusic,
                        artist: artist,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}