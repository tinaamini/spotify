import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/constant/app_color.dart';
class CustomBtnPlay extends StatelessWidget {
  final VoidCallback onTap;
  const CustomBtnPlay({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(height: 29.w,width: 29.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.w),
              color: AppColor.btnPlay
        ),
        child:Center(
          child:SvgPicture.asset('assets/icons/Play.svg'),
        )
      ),
    );
  }
}
