import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomBackPage extends StatelessWidget {
  final VoidCallback onTap;
  const CustomBackPage({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(width: 32.w,height: 32.w,
        decoration: BoxDecoration(
          color: AppColor.backPageBtn,
          borderRadius:  BorderRadius.circular(32.w),
        ),
        child: Center(child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Icon(Icons.arrow_back_ios,color: AppColor.solidWhite,),
        ))
      ),
    );
  }
}
