import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';

import '../../../constant/app_text_style.dart';
import '../../../core/di/di.dart';
import '../../../data/services/music/musicServer.dart';
import '../../../logic/cubit/music/artist_cubit.dart';
import '../../../logic/state/music/artist_state.dart';
import '../../widgets/customButtonBack.dart';
import '../../widgets/nav.dart';

class Artist extends StatelessWidget {

  const Artist({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor:AppColor.appNavColor,
            title: Padding(
              padding:  EdgeInsets.only(top: 15.w,right:55.w),
              child: Center(child: Text("Artist",style: AppTextStyle.TextBold,)),
            ),
            leading:   Padding(
              padding:EdgeInsets.only(top: 15.w,left: 15.w),
              child: CustomBackPage(onTap: (){
                context.go('/MainScreen?index=0');

              }),
            ),
          ),
        ),
        body: Column(
          children: [
            BlocProvider(
              create:
                  (context) => ArtistCubit(getIt<MusicServer>())..fetchArtists(),
              child: BlocBuilder<ArtistCubit, ArtistState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.error != null) {
                    return Center(child: Text('خطا: ${state.error}'));
                  }
                  if (state.artists.isEmpty) {
                    return Center(
                      child: Text(
                        'هیچ آرتیستی پیدا نشد',
                        style: AppTextStyle.TextBold,
                      ),
                    );
                  }
                  return Padding(
                    padding:  EdgeInsets.only(top: 20.w),
                    child: Container(height: 300.w,
                      child: ListView.builder(
                        itemCount: state.artists.length,
                        itemBuilder: (context, index) {
                          final artist = state.artists[index];
                          return ListTile(
                            title: Container(height:50.w,
                              decoration: BoxDecoration(
                                color: AppColor.list,
                                borderRadius: BorderRadius.circular(5.w),
                                border: Border.all(
                                  color: AppColor.solidWhite,
                                  width: 2.w,
                                ),
                              ),
                              child: Center(child: Text(artist.name, style: AppTextStyle.TextButton.copyWith(color: AppColor.appButtonColor))),
                            ),
                            onTap: () {
                              context.go('/MainScreen?index=4&artistId=${artist.id}&artistName=${artist.name}');

                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
