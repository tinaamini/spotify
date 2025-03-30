import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constant/app_color.dart';

import '../../../routes/routs_name.dart';
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}
class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {

      context.goNamed(RouteName.GetStarter);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        color: AppColor.appBackgroundColor,
        child: Center(
          child: SvgPicture.asset('assets/icons/Vector (6).svg'),
        ),
      ),
    ));
  }
}
