import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constant/app_text_style.dart';
import '../../../routes/routs_name.dart';
import '../../widgets/customButton.dart';

class Choosemode extends StatelessWidget {
  const Choosemode({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                bottom: 30.w,
                left: 35.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Choose mode ", style: AppTextStyle.TextBold),
                    SizedBox(height: 30.w),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Column(
                          //   children: [
                          //     Center(
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(50.w),
                          //         child: BackdropFilter(
                          //           filter: ImageFilter.blur(
                          //             sigmaX: 50,
                          //             sigmaY: 50,
                          //           ),
                          //           child: Container(
                          //             width: 73.w,
                          //             height: 73.w,
                          //             padding: EdgeInsets.all(20.w),
                          //             decoration: BoxDecoration(
                          //               color: Colors.white.withOpacity(0.1),
                          //               borderRadius: BorderRadius.circular(
                          //                 50.w,
                          //               ),
                          //             ),
                          //             child: SvgPicture.asset(
                          //               "assets/icons/Moon.svg",
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(height: 10.w),
                          //     Text("Dark mode",style: AppTextStyle.TextBold.copyWith(fontSize:17),)
                          //   ],
                          // ),
                          // SizedBox(width:40.w),
                          // Column(
                          //   children: [
                          //     Center(
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(50.w),
                          //         child: BackdropFilter(
                          //           filter: ImageFilter.blur(
                          //             sigmaX: 50,
                          //             sigmaY: 50,
                          //           ),
                          //           child: Container(
                          //             width: 73.w,
                          //             height: 73.w,
                          //             padding: EdgeInsets.all(20.w),
                          //             decoration: BoxDecoration(
                          //               color: Colors.white.withOpacity(0.1),
                          //               borderRadius: BorderRadius.circular(
                          //                 50.w,
                          //               ),
                          //             ),
                          //             child: SvgPicture.asset(
                          //               "assets/icons/Sun 1.svg",
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(height: 10.w),
                          //     Text("Light mode",style: AppTextStyle.TextBold.copyWith(fontSize:17),)
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.w),
                    Custombutton(
                      height: 92.w,
                      width: 329.w,
                      text: 'Continue',
                      onTap: () {
                        context.goNamed(RouteName.RegisterOrSingUp);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
