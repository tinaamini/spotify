import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_text_style.dart';
import '../../../routes/routs_name.dart';
import '../../widgets/customButton.dart';

class RegisterOrSingUp extends StatelessWidget {
  const RegisterOrSingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body: Container(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    'assets/icons/registerOrSignUp.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 300.w),
                  child: Container(width: double.infinity,
                    child: Column(
                      children: [
                        Text("Enjoy listening to music", style: AppTextStyle.TextBold),
                        SizedBox(height: 22.w,),
                        Padding(
                          padding:EdgeInsets.only(left:27.w),
                          child: Text("Spotify is a proprietary Swedish audio  ", style: AppTextStyle.Textlight),
                        ),
                        Padding(
                          padding:EdgeInsets.only(left: 22.w),
                          child: Text("streaming and media services provider ", style: AppTextStyle.Textlight),
                        ),
                        SizedBox(height: 32.w,),
                        Padding(
                          padding:EdgeInsets.only(left:40.w)
                          ,
                          child: Row(
                            children: [
                              Custombutton(
                                onTap: () {
                                  context.goNamed(RouteName.register);
                                },
                                height:73.w ,
                                width: 147.w,
                                text: 'Register',



                              ),
                              SizedBox(width:75.w,),
                              Container(
                                color: AppColor.appBackgroundColor,
                                height:73.w ,
                                width: 100.w,

                                child: GestureDetector(
                                  onTap: (){
                                    context.goNamed(RouteName.singIn);
                                  },
                                  child:

                                  Center(
                                    child: Text(
                                    'Sing in',style: AppTextStyle.TextButton,
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

        )
    );  }
}
