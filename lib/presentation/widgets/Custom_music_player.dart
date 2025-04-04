import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import 'dart:math' as math;
import 'package:spotify/core/di/di.dart';
import 'package:spotify/data/models/music/allMusicModel.dart';
import 'package:spotify/data/models/music/artistmodel.dart';
import 'package:spotify/logic/cubit/music/musicPlayer_cubit.dart';
import 'package:spotify/logic/state/music/musicPlayer_state.dart';
import 'customButtonBack.dart';

class CustomMusicPlayer extends StatelessWidget {
  final MusicModel initialMusic;
  final ArtistModel artist;

  const CustomMusicPlayer({
    super.key,
    required this.initialMusic,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      bloc: getIt<MusicPlayerCubit>(),
      builder: (context, state) {
        final currentMusic = state.music ?? initialMusic;

        return Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.showLyrics
                  ? Container()
                  : Padding(
                    padding: EdgeInsets.only(top: 25.w, left: 5.w),
                    child: Container(
                      width: 335.w,
                      height: 370.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.w),
                        image: DecorationImage(
                          image: NetworkImage(currentMusic.coverUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 15.w),
              Row(
                mainAxisAlignment:
                    state.showLyrics
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                children: [
                  state.showLyrics
                      ? Padding(
                        padding: EdgeInsets.only(left: 18.w),
                        child: Container(
                          width: 42.w,
                          height: 42.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.w),
                            image: DecorationImage(
                              image: NetworkImage(currentMusic.coverUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      : Container(),
                  state.showLyrics ? SizedBox(width: 15.w) : Container(),
                  Column(
                    children: [
                      Text(
                        currentMusic.name,
                        style: AppTextStyle.TextBold.copyWith(
                          fontSize: state.showLyrics ? 16.w : 20.w,
                        ),
                      ),
                      SizedBox(height: 3.w),
                      Text(
                        artist.name,
                        style: AppTextStyle.Textlight.copyWith(
                          fontSize: state.showLyrics ? 12.w : 20.w,
                        ),
                      ),
                    ],
                  ),
                  state.showLyrics ? SizedBox(width: 200.w) : Container(),
                  GestureDetector(
                    onTap: () {
                    },
                    child: SvgPicture.asset(
                      "assets/icons/Heart.svg",
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: state.showLyrics ? 0.w : 30.w),
              _buildSeekBar(context, state),
              SizedBox(height: 35.w),
              GestureDetector(
                onTap: () {
                  context.read<MusicPlayerCubit>().toggleLyrics();
                },
                child:
                    state.showLyrics
                        ? Container()
                        : Column(
                          children: [
                            Center(
                              child: Transform.rotate(
                                angle: math.pi / 2,
                                child: CustomBackPage(onTap: () {}),
                              ),
                            ),
                            SizedBox(height: 5.w),
                            Center(
                              child: Text(
                                "Lyrics",
                                style: AppTextStyle.Textlight.copyWith(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSeekBar(BuildContext context, MusicPlayerState state) {
    final position = state.position.inSeconds.toDouble();
    final duration = state.duration?.inSeconds.toDouble() ?? 0.0;

    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColor.activeTrackColor,
            inactiveTrackColor: AppColor.inactiveTrackColor,
            thumbColor: AppColor.activeTrackColor,
            trackHeight: 2.w,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.w),
          ),
          child: Slider(
            value: position,
            min: 0.0,
            max: duration > 0 ? duration : 1.0,
            onChanged: (value) {
              context.read<MusicPlayerCubit>().seek(
                Duration(seconds: value.toInt()),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(state.position), style: AppTextStyle.Timer),
              Text(
                _formatDuration(state.duration ?? Duration.zero),
                style: AppTextStyle.Timer,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: state.showLyrics ? 30.w : 0.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<MusicPlayerCubit>().toggleRepeat();
                  print(state.isRepeating);
                },
                child: SvgPicture.asset(
                  state.isRepeating
                      ? "assets/icons/repeat-2-svgrepo-com (3).svg"
                      : "assets/icons/repeat-2-svgrepo-com (2).svg",
                ),
              ),
              GestureDetector(
                onTap: () {
                  getIt<MusicPlayerCubit>().playPrevious();
                },
                child: SvgPicture.asset("assets/icons/Previous.svg"),
              ),
              GestureDetector(
                onTap: () {
                  if (state.isPlaying) {
                    getIt<MusicPlayerCubit>().pause();
                  } else {
                    getIt<MusicPlayerCubit>().play();
                  }
                },
                child: Container(
                  width: state.showLyrics ? 51.w : 72.w,
                  height: state.showLyrics ? 51.w : 72.w,
                  decoration: BoxDecoration(
                    color: AppColor.appButtonColor,
                    borderRadius: BorderRadius.circular(35.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.w,
                      bottom: 15.w,
                      right: 3.w,
                    ),
                    child: SvgPicture.asset(
                      state.isPlaying
                          ? "assets/icons/Pause.svg"
                          : "assets/icons/Play.svg",
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  getIt<MusicPlayerCubit>().playNext();
                },
                child: SvgPicture.asset("assets/icons/Next.svg"),
              ),

              GestureDetector(
                onTap: () {
                  context.read<MusicPlayerCubit>().toggleShuffle();

                },
                child:   SvgPicture.asset(
                    state.isShuffling ? "assets/icons/shuffle-01-svgrepo-com.svg":"assets/icons/Shuffle 2.svg"),
              ),

            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
