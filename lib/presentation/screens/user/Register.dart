import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/routes/routs_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant/app_text_style.dart';
import '../../../core/di/di.dart';
import '../../../data/services/user/Auth.dart';
import '../../../logic/cubit/user/register_cubit.dart';
import '../../../logic/state/user/register_state.dart';
import '../../widgets/TextField.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customButtonBack.dart';

class Register extends StatelessWidget {
  final VoidCallback onTap;


  Register({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => RegisterCubit(getIt<AuthService>()),
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
                  "Register",
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
                        context.goNamed(RouteName.mainHome);
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
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state.success) {
                context.goNamed(RouteName.SingIn); // نویگیشن اینجا انجام می‌شه
              } else if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error!)),
                );
              }
            },
            child:BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(top: 30.w),
                      child: Column(
                        children: [
                          CustomTextField(
                            obscureText: false,
                            onChanged: (value) => context.read<RegisterCubit>().updateFullName(value),
                            label: "Full Name",
                          ),
                          SizedBox(height: 25.w),
                          CustomTextField(
                            obscureText: false,
                            onChanged: (value) => context.read<RegisterCubit>().updateEmail(value),
                            label: "Enter Email",
                          ),
                          SizedBox(height: 25.w),
                          CustomTextField(
                            obscureText: false,
                            onChanged: (value) => context.read<RegisterCubit>().updatePassword(value),
                            label: "Password",
                          ),

                          SizedBox(height: 20.w),
                          Custombutton(
                            height: 80.w,
                            width: 335,
                            text: "Create Accouznt",
                            // onTap: () async {
                            //   await context.read<RegisterCubit>().register();
                            //   // if (state.success) {
                            //   //   context.goNamed(RouteName.SingIn);
                            //   // } else if (state.error != null) {
                            //   //   ScaffoldMessenger.of(context).showSnackBar(
                            //   //     SnackBar(content: Text(state.error!)),
                            //   //   );
                            //   // }
                            // },
                            onTap: state.isLoading ?null : (){
                              context.read<RegisterCubit>().register();
                            },
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
                          SizedBox(height: 25.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'not a member ? ',
                                style: AppTextStyle.TextBold.copyWith(
                                  fontSize: 14.w,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.goNamed(RouteName.Register);
                                },
                                child: Text(
                                  'Register Now ',
                                  style: AppTextStyle.TextBold.copyWith(
                                    fontSize: 14.w,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
