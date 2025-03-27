import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body:Padding(
            padding: EdgeInsets.only(top: 30.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(onTap: (){},
                  child: SvgPicture.asset("assets/icons/Vector.svg"),
                ),
                SvgPicture.asset("assets/icons/Vector (4).svg"),
                GestureDetector(onTap: (){},

                    child: Icon(Icons.more_vert,color: Colors.white,))
              ],
            ),
          ) ,
        ));
  }
}
