import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_color.dart';
import '../../constant/app_text_style.dart';
import 'customButtonBack.dart';

class TopBtns extends StatelessWidget {
  const TopBtns({super.key, this.ontap, this.text});
final ontap;
final text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackPage(
          onTap:ontap
        ),

           Text(text
              ,
              style: AppTextStyle.TextBold.copyWith(fontSize: 18.w),
            ),

        Icon(Icons.more_vert, color: AppColor.solidWhite),
      ],
    );
  }
}
