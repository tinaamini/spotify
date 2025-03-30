import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';

import '../../../core/di/di.dart';
import '../../../logic/cubit/user/userProfile_cubit.dart';
import '../../../logic/state/user/userProfile_state.dart';
import '../../../routes/routs_name.dart';
import '../../widgets/customButtonBack.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static bool _isCubitRegistered = false;

  @override
  Widget build(BuildContext context) {
    if (!_isCubitRegistered) {
      getIt.registerFactory(() => ProfileCubit());
      _isCubitRegistered = true;
    }
    return SafeArea(child:Scaffold(
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child:Column(
          children: [
            _buildProfile(context),
          ],
        ) ,
      ),
    ));
  }

  Widget _buildProfile(BuildContext context) {


    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
    if (state is ProfileInitial) {
    return Center(child: Text('در حال آماده‌سازی...', style: AppTextStyle.Textlight));
    } else if (state is ProfileLoading) {
    return Center(child: CircularProgressIndicator());
    }else if (state is ProfileError) {
    return Center(child: Text(state.message, style: AppTextStyle.Textlight));
    }
    else if (state is ProfileLoaded) {
    final user = state.userProfile;
    return
      Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding:EdgeInsets.all(25.w),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackPage(
                          onTap: (){context.goNamed(RouteName.mainHome);},
                        ),

                        Text("Profile",style:AppTextStyle.Textlight.copyWith(fontWeight: FontWeight.w700),),

                        Icon(Icons.more_vert,color:AppColor.solidWhite,)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      child: Container(width: 93.w,height: 93.w,
                        child:SvgPicture.asset("assets/icons/avatar-girl-svgrepo-com.svg") ,
                      ),
                    ),
                    Text(user.full_name)
                    


                  ],
                ),
              ),
            )
          ],
        ),
      );

    }
    return Container();
    }
    )
    );
  }

  
  
}
