import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/data/services/tokenmanager.dart';
import 'package:spotify/logic/cubit/splash/splash_cubit.dart';
import '../../../constant/app_text_style.dart';
import '../../../logic/state/splash/splash_state.dart';
import '../../../routes/routs_name.dart';
import '../../widgets/customButton.dart';

class Choosemode extends StatefulWidget {
  const Choosemode({super.key});

  @override
  _ChoosemodeState createState() => _ChoosemodeState();
}

class _ChoosemodeState extends State<Choosemode> {
  bool chooseMood = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SplashCubit(TokenManager())..checkToken(),
    child: SafeArea(
      child: Scaffold(
      body: Container(
          child: Stack(
            children: [
              Image.asset(
                'assets/icons/doalipa.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40.w,
                left: 90.w,
                child: SvgPicture.asset("assets/icons/Vector (6).svg"),
              ),
              Positioned(
                bottom: 198.w,
                left: chooseMood ?0.w:133.w,
                right: chooseMood ?127.w:0.w,
                child: Container(
                  child: SvgPicture.asset("assets/icons/Rectangle 22.svg"),
                ),
              ),
              Positioned(
                bottom: 30.w,
                left: 35.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Choose mode", style: AppTextStyle.TextBold),
                    SizedBox(height: 30.w),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                chooseMood = true;
                              });
                            },
                            child: Column(
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.w),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                                      child: Container(
                                        width: 73.w,
                                        height: 73.w,
                                        padding: EdgeInsets.all(20.w),
                                        decoration: BoxDecoration(
                                          color: chooseMood
                                              ? AppColor.ChoosMood.withOpacity(0.3)
                                              : AppColor.backPageBtn.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(50.w),
                                        ),
                                        child: SvgPicture.asset("assets/icons/Moon.svg"),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.w),
                                Text(
                                  "Dark mode",
                                  style: AppTextStyle.TextBold.copyWith(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 40.w),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                chooseMood = false;
                              });
                            },
                            child: Column(
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.w),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                                      child: Container(
                                        width: 73.w,
                                        height: 73.w,
                                        padding: EdgeInsets.all(20.w),
                                        decoration: BoxDecoration(
                                          color: !chooseMood
                                              ? AppColor.ChoosMood.withOpacity(0.3)
                                              : AppColor.backPageBtn.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(50.w),
                                        ),
                                        child: SvgPicture.asset("assets/icons/Sun 1.svg"),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.w),
                                Text(
                                  "Light mode",
                                  style: AppTextStyle.TextBold.copyWith(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.w),
                BlocListener<SplashCubit, SplashState>(
                  listener: (context, state) {
                    if (!state.isLoading) {
                      if (state.hasToken) {
                        context.goNamed(RouteName.mainHome);
                      } else {
                        context.goNamed(RouteName.registerOrSingUp, extra: {'mode': chooseMood});
                      }
                    }

                  },
                child:  Custombutton(
                  height: 92.w,
                  width: 329.w,
                  text: 'Continue',
                  onTap: () {

                  },
                ) ,),

                  ],
                ),
              ),
            ],
          ),
        ) ,
      )
      )

    );
    }}

