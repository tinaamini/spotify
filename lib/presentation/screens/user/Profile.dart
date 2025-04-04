import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';
import 'package:spotify/core/di/di.dart';
import 'package:spotify/logic/cubit/user/userProfile_cubit.dart';
import 'package:spotify/logic/state/user/userProfile_state.dart';
import 'package:spotify/routes/routs_name.dart';
import '../../widgets/customButtonBack.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ساخت دستی نمونه ProfileCubit
  final ProfileCubit _profileCubit = ProfileCubit();

  @override
  void initState() {
    super.initState();
    _profileCubit.loadProfile(); // بارگذاری پروفایل هنگام شروع
  }

  @override
  void dispose() {
    _profileCubit.close(); // آزادسازی Cubit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _buildProfile(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return Center(child: Text('در حال آماده‌سازی...', style: AppTextStyle.Textlight));
        } else if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileError) {
          return Center(child: Text(state.message, style: AppTextStyle.Textlight));
        } else if (state is ProfileLoaded) {
          final user = state.userProfile;
          return Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.btnPlay,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25.w),
                      bottomLeft: Radius.circular(25.w),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(25.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackPage(
                              onTap: () {
                                context.goNamed(RouteName.mainHome);
                              },
                            ),
                            Text(
                              "Profile",
                              style: AppTextStyle.TextBold.copyWith(fontSize: 17.w),
                            ),
                            Icon(Icons.more_vert, color: AppColor.solidWhite),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          child: Container(
                            width: 93.w,
                            height: 93.w,
                            child: SvgPicture.asset("assets/icons/avatar-girl-svgrepo-com.svg"),
                          ),
                        ),
                        Text(
                          user.email,
                          style: AppTextStyle.Textlight.copyWith(fontSize: 12.w),
                        ),
                        SizedBox(height: 20.w),
                        Text(
                          user.full_name,
                          style: AppTextStyle.TextBold.copyWith(fontSize: 20.w),
                        ),
                        SizedBox(height: 20.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "778",
                                  style: AppTextStyle.TextBold.copyWith(fontSize: 20.w),
                                ),
                                SizedBox(height: 5.w),
                                Text(
                                  "Followers",
                                  style: AppTextStyle.Textlight.copyWith(fontSize: 12.w),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "243",
                                  style: AppTextStyle.TextBold.copyWith(fontSize: 20.w),
                                ),
                                SizedBox(height: 5.w),
                                Text(
                                  "Following",
                                  style: AppTextStyle.Textlight.copyWith(fontSize: 12.w),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}