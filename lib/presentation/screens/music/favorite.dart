import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_text_style.dart';
class FaveritScreen extends StatelessWidget {
  const FaveritScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("favorite",style: AppTextStyle.TextBold,),
      ),
    );
  }
}
