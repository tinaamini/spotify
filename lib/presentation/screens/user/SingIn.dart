import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/routes/routs_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant/app_text_style.dart';
import '../../../di/di.dart';
import '../../../logic/cubit/text_field_cubit.dart';
import '../../../logic/state/text_field_state.dart';
import '../../widgets/TextField.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customButtonBack.dart';

class SingIn extends StatelessWidget {
  final VoidCallback onTap;
  final TextFieldCubit cubit = getIt<TextFieldCubit>();

  SingIn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: cubit,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.w, left: 30.w),
                  child: Row(
                    children: [
                      BackPage(
                        onTap: () {
                          context.goNamed(RouteName.RegisterOrSingUp);
                        },
                      ),
                      SizedBox(width: 85.w),
                      SvgPicture.asset("assets/icons/Vector (4).svg"),
                    ],
                  ),
                ),
                SizedBox(height: 70.w),
                Text(
                  "Sing In",
                  style: AppTextStyle.TextBold.copyWith(fontSize: 30.w),
                ),
                SizedBox(height: 20.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If you need any support",
                      style: TextStyle(
                        fontSize: 12.w,
                        fontWeight: FontWeight.w400,
                        color: AppColor.solidWhite,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(RouteName.Home);
                      },
                      child: Text(
                        "click here",
                        style: TextStyle(
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                          color: AppColor.appButtonColor,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<TextFieldCubit, TextFieldState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(top: 30.w),
                      child: Column(
                        children: [
                          CustomTextField(
                            obscureText: false,
                            onChanged: cubit.updateEmail,
                            label: "enter username or email",
                          ),
                          SizedBox(height: 25.w),
                          CustomTextField(
                            obscureText: true,
                            onChanged: cubit.updatePassword,
                            label: "password",
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 200.w, top: 25.w),
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Recovery password",
                                style: AppTextStyle.TextButton.copyWith(
                                  fontSize: 13.w,
                                  color: AppColor.greenwhite,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:20.w),
                          Custombutton(
                            height: 80.w,
                            width: 335,
                            text: "Sing in",
                            onTap: () {},
                          ),
                          SizedBox(height: 30.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100.w,
                                height: 1.w,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(91, 91, 91, 1),
                                      Color.fromRGBO(37, 37, 37, 1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              Text(
                                "Or",
                                style: AppTextStyle.Textlight.copyWith(
                                  fontSize: 12.w,
                                ),
                              ),
                              Container(
                                width: 100.w,
                                height: 1.w,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(91, 91, 91, 1),
                                      Color.fromRGBO(37, 37, 37, 1),
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/google.svg"),
                              SizedBox(width: 70.w),
                              SvgPicture.asset("assets/icons/apple.svg"),
                            ],
                          ),
                          SizedBox(height: 25.w,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('not a member ? ',style: AppTextStyle.TextBold.copyWith(fontSize: 14.w),),
                              GestureDetector(
                                onTap: (){
                                  context.goNamed(RouteName.Register);
                                },
                                child:
                                  Text('Register Now ',style: AppTextStyle.TextBold.copyWith(fontSize: 14.w,color:Colors.blue),),


                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
