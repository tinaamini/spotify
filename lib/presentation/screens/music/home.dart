import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import '../../../core/di/di.dart';
import '../../../core/network/api_client.dart';
import '../../../data/models/music/ListModel.dart';
import '../../../data/models/music/artistmodel.dart';
import '../../../data/services/music/musicServer.dart';
import '../../../data/services/tokenmanager.dart';
import '../../../logic/cubit/music/allMusic_cubit.dart';
import '../../../logic/cubit/music/artist_cubit.dart';
import '../../../logic/cubit/music/tab_cubit.dart';
import '../../../logic/state/music/allMusic_State.dart';
import '../../../logic/state/music/artist_state.dart';
import '../../../logic/state/music/tabState.dart';
import '../../../routes/routs_name.dart';
import '../../widgets/btn_play.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> tabs = ['News', 'Video', 'Artist', 'Podcast'];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TabCubit()),
        BlocProvider(
          create:
              (context) =>
                  AllMusicCubit(MusicServer(getIt<ApiClient>()))..fetchMusics(),
        ),
        BlocProvider(
          create:
              (context) => ArtistCubit(getIt<MusicServer>())..fetchArtists(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body:BlocListener<AllMusicCubit, AllMusicState>(
    listener: (context, state) {
    if (state is ErrorMusic && state.isTokenInvalid) {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("توکن شما منقضی شده است. لطفاً دوباره وارد شوید.")),
    );
    getIt<TokenManager>().clearToken();
    context.goNamed(RouteName.singIn);
    }
    },
    child:SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset("assets/icons/Vector.svg"),
                ),
                SvgPicture.asset("assets/icons/Vector (4).svg"),
                GestureDetector(
                  onTap: () {},

                  child: Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),
          _buildBanner(context),
          _buildList(context),
          _buildArtist(context),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
              vertical: 28.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Playlist", style: AppTextStyle.TextButton),
                GestureDetector(
                  onTap: () {},
                  child: Text("See More", style: AppTextStyle.Textlight),
                ),
              ],
            ),
          ),
          _buildPlayList(context),
        ],
      ),
    ),

        ),
      ),
    ));
  }

  Widget _buildBanner(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.w),
      child: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/icons/banner.svg',
              fit: BoxFit.cover,
              color: null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.w, left: 30.w),
      child: Container(
        height: 50.w,
        child: BlocBuilder<TabCubit, TabState>(
          builder: (context, state) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<TabCubit>().selectTab(index);
                    if (tabs[index].toLowerCase() == 'artist') {
                      context.goNamed(RouteName.artist);
                    }
                  },
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontSize: 20.w,
                              color:
                                  state.selectedIndex == index
                                      ? AppColor.solidWhite
                                      : AppColor.list,
                            ),
                          ),
                        ),
                        SizedBox(height: 3),
                        if (state.selectedIndex == index)
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.appButtonColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.w),
                                bottomRight: Radius.circular(5.w),
                              ),
                            ),
                            height: 3.w,
                            width: 26.w,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  final List<ListModel> imageItems = [
    ListModel('assets/icons/Rectangle 8 (2).png', 'Bad Guy', 'Billie Eilish'),
    ListModel('assets/icons/Rectangle 9 (2).png', 'Scorpion', 'Drake'),
    ListModel(
      'assets/icons/Rectangle 9 (1).png',
      'WHEN WE ...',
      'Billie Eilish',
    ),
  ];

  Widget _buildArtist(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, top: 20.w),
      child: Container(
        height: 240.h,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageItems.length,
          itemBuilder: (context, index) {
            final item = imageItems[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 147.w,
                        height: 185.h,
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
                        item.nameMusic,
                        style: AppTextStyle.TextBold.copyWith(fontSize: 16.w),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        item.nameArtist,
                        style: AppTextStyle.TextBold.copyWith(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 45.w,
                    right: 12.w,
                    child: CustomBtnPlay(onTap: () {}),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayList(BuildContext context) {
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
              return Center(
                child: Text('Error loading artists: ${state.error}'),
              );
            }
            return BlocBuilder<AllMusicCubit, AllMusicState>(
              builder: (context, musicState) {
                if (musicState is LoadingMusic) {
                  return const Center(child: CircularProgressIndicator());
                } else if (musicState is LoadedMusic) {
                  return
                    ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: musicState.musics.length,
                    itemBuilder: (context, index) {
                      final music = musicState.musics[index];
                      final artist = state.artists.firstWhere(
                        (artist) => artist.id == music.artistId,
                        orElse:
                            () => ArtistModel(
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
                                  print('Play: ${music.audioUrl}');
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
                                  music.name.length > 10
                                      ? '${music.name.substring(0, 10)}...'
                                      : music.name,
                                  style: AppTextStyle.TextBold.copyWith(
                                    fontSize: 16.w,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  artist.name,
                                  style: AppTextStyle.TextBold.copyWith(
                                    fontSize: 12.w,
                                  ),
                                ),
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
                                  context.read<AllMusicCubit>().unlikeMusic(
                                    music.id,
                                  );
                                } else {
                                  context.read<AllMusicCubit>().likeMusic(
                                    music.id,
                                  );
                                }
                              },
                              child: SvgPicture.asset(
                                music.isLiked
                                    ? "assets/icons/Heart3.svg"
                                    : "assets/icons/Heart.svg",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (musicState is ErrorMusic) {
                  return Center(child: Text('Error: ${musicState.message}'));
                } else {
                  return const Center(child: Text('No music loaded yet'));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
