import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/constant/app_color.dart';
import '../screens/music/favorite.dart';
import '../screens/music/home.dart';
import '../screens/user/Profile.dart';
import '../screens/music/discovery.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // لیست صفحات
  final List<Widget> _screens = [
    Home(),
    DiscoveryScreen(),
    FaveritScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 4;
    final linePosition = itemWidth * _selectedIndex + (itemWidth - 23.w) / 2;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _screens[_selectedIndex]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 73.w,
              child: BottomNavigationBar(
                backgroundColor: AppColor.appNavColor,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: AppColor.appButtonColor,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(fontSize: 14.sp),
                unselectedLabelStyle: TextStyle(fontSize: 12.sp),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        SvgPicture.asset(
                          _selectedIndex == 0
                              ? 'assets/icons/Home 2.svg'
                              : 'assets/icons/Home.svg',
                          width: 30.w,
                          height: 30.h,
                        ),
                      ],
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        SizedBox(height: 5.h),
                        SvgPicture.asset(
                          _selectedIndex == 1
                              ? 'assets/icons/Discovery 1.svg'
                              : 'assets/icons/Discovery 1.svg',
                          width: 30.w,
                          height: 30.h,
                        ),
                      ],
                    ),
                    label: 'Discovery',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        SvgPicture.asset(
                          _selectedIndex == 2
                              ? 'assets/icons/Heart3.svg'
                              : 'assets/icons/Heart 1.svg',
                          width: 30.w,
                          height: 30.h,
                        ),
                      ],
                    ),
                    label: 'Heart',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        SvgPicture.asset(
                          _selectedIndex == 3
                              ? 'assets/icons/Profile 1.svg'
                              : 'assets/icons/Profile 1.svg',
                          width: 30.w,
                          height: 30.h,
                        ),
                      ],
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: linePosition,
            bottom: 75,
            child: Container(height: 4.h,width: 23.w,
            decoration: BoxDecoration(
              color: AppColor.appButtonColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4.w),
                bottomRight: Radius.circular(4.w),
              )
            ),
            ),
          ),
        ],
      ),
    );
  }
}
