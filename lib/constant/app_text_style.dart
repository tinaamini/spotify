import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';
class AppTextStyle{

  static TextStyle TextBold = TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 26.w,
    fontWeight: FontWeight.w700,
    color: AppColor.textBold,
  );
  static TextStyle Textlight = TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 17.w,
    fontWeight: FontWeight.w400,
    color: AppColor.textlight,
  );
  static TextStyle TextButton = TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 19.5.w,
    fontWeight: FontWeight.w700,
    color: AppColor.textBold,
  );
  static TextStyle Timer = TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 12.w,
    fontWeight: FontWeight.w700,
    color: AppColor.timer,
  );

}