import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_text_style.dart';
class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Discovery",style: AppTextStyle.TextBold,),
      ),
    );
  }
}
