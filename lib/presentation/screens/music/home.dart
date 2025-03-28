import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';

import '../../../data/models/music/artistmodel.dart';
import '../../../data/models/music/playlistModel.dart';
import '../../../di/di.dart';
import '../../../logic/cubit/music/tab_cubit.dart';
import '../../../logic/state/music/tabState.dart';
import '../../widgets/btn_play.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> tabs = ['News', 'Video', 'Artist', 'Podcast'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TabCubit>(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
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
    );
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

  final List<ArtistModel> imageItems = [
    ArtistModel(
      imagePath: 'assets/icons/Rectangle 8 (2).png',
      nameMusic: 'Bad Guy',
      nameArtist: 'Billie Eilish',
    ),
    ArtistModel(
      imagePath: 'assets/icons/Rectangle 9 (2).png',
      nameMusic: 'Scorpion',
      nameArtist: 'Drake',
    ),
    ArtistModel(
      imagePath: 'assets/icons/Rectangle 9 (1).png',
      nameMusic: 'WHEN WE ...',
      nameArtist: 'Billie Eilish',
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
  final List<PlayListModel> playlist = [
    PlayListModel(
      nameMusic: 'As It Was',
      nameArtist: 'Harry Styles',
        timeMusic:'5:33'
    ),
    PlayListModel(

      nameMusic: 'God Did',
      nameArtist: 'DJ Khaled',
        timeMusic:'3:43'
    ),

  ];
  Widget _buildPlayList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:30.w),
      child: Container(width: double.infinity,height: 300.w,
        child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: playlist.length,
        itemBuilder: (context, index) {
          final item = playlist[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(width: 37.w,height: 37.w,
                    child: CustomBtnPlay(onTap: (){})),
                SizedBox(width: 25.w,),
                Column(
                  children: [
                    Text(
                      item.nameMusic,
                      style: AppTextStyle.TextBold.copyWith(fontSize: 16.w),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item.nameArtist,
                      style: AppTextStyle.TextBold.copyWith(fontSize: 12.w),
                    ),
                  ],
                ),
                SizedBox(width:65.w),
                Text(
                  item.timeMusic,
                  style: AppTextStyle.TextBold.copyWith(
                    fontSize: 15.w,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 15.w,),
                GestureDetector(onTap: (){},
                    child: SvgPicture.asset("assets/icons/Heart.svg"))

              ],
            ),
          );
        },
              ),
      ),
    );
  }



}
