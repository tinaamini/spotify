import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/constant/app_color.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final String? errorText;
  final void Function(String) onChanged;


  const CustomTextField({
    super.key,
    required this.label,
    required this.obscureText,
    this.errorText,
    required this.onChanged,

  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.w,
      child: TextFormField(
        obscureText: widget.obscureText,
        keyboardType: TextInputType.multiline,
        style: TextStyle(
          color: Colors.white, // رنگ متن نوشته‌شده
          fontSize: 16.w,
        ),
        decoration: InputDecoration(
          hintText: widget.label,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(width:1.w),
            borderRadius: BorderRadius.circular(30.w),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColor.appButtonColor),
              borderRadius: BorderRadius.circular(30.w)
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 25.w),
          fillColor: AppColor.appBackgroundColor,
          errorText: widget.errorText,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}