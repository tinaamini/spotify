import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/constant/app_text_style.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("profile",style: AppTextStyle.TextBold,),
      ),
    );
  }
}
