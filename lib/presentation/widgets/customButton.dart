import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:spotify/constant/app_text_style.dart';

class Custombutton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final void Function()? onTap;

  const Custombutton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.onTap,

  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.w),
          color: AppColor.appButtonColor

        ),
        child: Center(
          child: Text(text,style: AppTextStyle.TextButton,),
        ),
      ),

    );
  }
}
