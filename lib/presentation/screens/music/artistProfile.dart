import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import 'package:spotify/core/di/di.dart';
import 'package:spotify/data/models/music/ListModel.dart';
import 'package:spotify/data/models/music/artistmodel.dart';
import 'package:spotify/data/services/music/musicServer.dart';
import 'package:spotify/logic/cubit/music/allMusic_cubit.dart';
import 'package:spotify/logic/cubit/music/artist_cubit.dart';
import 'package:spotify/logic/state/music/allMusic_State.dart';
import 'package:spotify/logic/state/music/artist_state.dart';
import 'package:spotify/routes/routs_name.dart';
import '../../../data/services/tokenmanager.dart';
import '../../../logic/cubit/music/musicPlayer_cubit.dart';
import '../../widgets/btn_play.dart';
import '../../widgets/customButtonBack.dart';

class ArtistProfile extends StatelessWidget {
  final int artistId;
  final String? artistName;

  const ArtistProfile({super.key, required this.artistId, this.artistName});

  @override
  Widget build(BuildContext context) {
    final musicPlayerCubit = getIt<MusicPlayerCubit>();
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AllMusicCubit(getIt<MusicServer>())..fetchMusics(artistId: artistId),
            ),
            BlocProvider(
              create: (context) => ArtistCubit(getIt<MusicServer>())..fetchArtists(),
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
            child: BlocBuilder<AllMusicCubit, AllMusicState>(
              builder: (context, state) {
                if (state is LoadingMusic) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedMusic) {
                  final musics = state.musics;
                  if (musics.isEmpty) {
                    return Center(
                      child: Text(
                        'هیچ آهنگی برای این آرتیست پیدا نشد',
                        style: AppTextStyle.TextBold,
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          height: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(35.w),
                              bottomLeft: Radius.circular(35.w),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(musics[0].coverUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomBackPage(
                                  onTap: () {
                                    context.goNamed(RouteName.artist);
                                  },
                                ),
                                Icon(Icons.more_vert, color: AppColor.solidWhite),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          artistName ?? 'Unknown Artist',
                          style: AppTextStyle.TextBold.copyWith(fontSize: 20.w),
                        ),
                        SizedBox(height: 10.w),
                        Text(
                          "2 Album , ${musics.length} Track",
                          style: AppTextStyle.Textlight.copyWith(fontSize: 13.w),
                        ),
                        SizedBox(height: 13.w),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 45.w),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis adipiscing vestibulum orci enim, nascetur vitae ",
                            style: AppTextStyle.Textlight.copyWith(fontSize: 13.w),
                          ),
                        ),
                        _buildArtist(context),
                        _buildPlayList(context, artistId),
                      ],
                    ),
                  );
                } else if (state is ErrorMusic) {
                  if (!state.isTokenInvalid) {
                    return Center(child: Text('خطا: ${state.message}', style: AppTextStyle.TextBold));
                  }
                  return const SizedBox();
                }
                return const Center(child: Text('هیچ داده‌ای بارگذاری نشده'));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArtist(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, top: 20.w),
      child: Container(
        height: 200.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageItems.length,
          itemBuilder: (context, index) {
            final item = imageItems[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 135.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: AssetImage(item.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    item.nameMusic.length > 15
                        ? '${item.nameMusic.substring(0, 15)}...'
                        : item.nameMusic,
                    style: AppTextStyle.TextBold.copyWith(fontSize: 13.w),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayList(BuildContext context, int artistId) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        width: double.infinity,
        height: 300.w,
        child: BlocBuilder<ArtistCubit, ArtistState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('خطا در بارگذاری آرتیست‌ها: ${state.error}', style: AppTextStyle.TextBold));
            }
            return BlocBuilder<AllMusicCubit, AllMusicState>(
              builder: (context, musicState) {
                if (musicState is LoadingMusic) {
                  return const Center(child: CircularProgressIndicator());
                } else if (musicState is LoadedMusic) {
                  final artistMusics = musicState.musics.where((music) => music.artistId == artistId).toList();
                  if (artistMusics.isEmpty) {
                    return Center(
                      child: Text(
                        'هیچ آهنگی برای این آرتیست موجود نیست',
                        style: AppTextStyle.TextBold,
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: artistMusics.length,
                    itemBuilder: (context, index) {
                      final music = artistMusics[index];
                      final artist = state.artists.firstWhere(
                            (artist) => artist.id == music.artistId,
                        orElse: () => ArtistModel(
                          id: music.artistId,
                          name: 'Unknown Artist',
                        ),
                      );
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 37.w,
                              height: 37.w,
                              child: CustomBtnPlay(
                                onTap: () {
                                  getIt<MusicPlayerCubit>().loadMusic(music, artistMusics);
                                  context.goNamed(
                                    RouteName.musicPage,
                                    extra: {'music': music, 'artist': artist},
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 25.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  music.name.length > 8
                                      ? '${music.name.substring(0, 8)}...'
                                      : music.name,
                                  style: AppTextStyle.TextBold.copyWith(fontSize: 16.w),
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                            SizedBox(width: 65.w),
                            Text(
                              'N/A',
                              style: AppTextStyle.TextBold.copyWith(
                                fontSize: 15.w,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () {
                                if (music.isLiked) {
                                  context.read<AllMusicCubit>().unlikeMusic(music.id);
                                } else {
                                  context.read<AllMusicCubit>().likeMusic(music.id);
                                }
                              },
                              child: SvgPicture.asset(
                                music.isLiked ? "assets/icons/Heart3.svg" : "assets/icons/Heart.svg",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (musicState is ErrorMusic) {
                  if (!musicState.isTokenInvalid) {
                    return Center(child: Text('خطا: ${musicState.message}'));
                  }
                  return const SizedBox();
                }
                return const Center(child: Text('هیچ آهنگی بارگذاری نشده'));
              },
            );
          },
        ),
      ),
    );
  }
}

final List<ListModel> imageItems = [
  ListModel('assets/icons/Rectangle 16.png', 'lilbubblegum', 'Billie Eilish'),
  ListModel('assets/icons/Rectangle 17.png', 'Happier Than Ever', 'Billie Eilish'),
  ListModel('assets/icons/Rectangle 16.png', 'dont smile at me', 'Billie Eilish'),
];