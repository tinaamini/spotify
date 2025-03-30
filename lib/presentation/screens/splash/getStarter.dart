import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_text_style.dart';

import '../../../routes/routs_name.dart';
import '../../widgets/customButton.dart';
class GetStarter extends StatelessWidget {
  const GetStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/icons/ariana.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(top: 40.w,left: 90.w,
                child: SvgPicture.asset("assets/icons/Vector (6).svg")),
            
            Positioned(bottom:30.w,left: 35.w,
                child:Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Enjoy Listening to Music",style: AppTextStyle.TextBold,),
                SizedBox(height: 30.w,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: 297.w,
                      child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.",style: AppTextStyle.Textlight,textAlign: TextAlign.center,)),
                ),
                SizedBox(height: 40.w,),
                Custombutton(height: 92.w,width: 329.w, text: 'Get Started',
                  onTap: () {      context.goNamed(RouteName.Choosemode);
                  },)
              ],
            ) )
          ],
        ),
        ),
      ),
    );
  }
}
