import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../helper/size_config.dart';
import '../../cart/views/cart_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {

    SizeConfig.init(context);

    List<Widget> _buildScreens() {
      return [    HomeView(),    CartView(),    ProfileView(),  ];
    }
    double screenWidth = MediaQuery.of(context).size.width;

    List<PersistentBottomNavBarItem> _navBarsItems(){
      return [

        PersistentBottomNavBarItem(
          icon:  Icon(Icons.home,size:  SizeConfig.getScaledSize(30)),
          title: "Home",
          textStyle: TextStyle(fontSize: SizeConfig.getScaledSize(12) ),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(

          icon:  Icon(Icons.shopping_cart,size:  SizeConfig.getScaledSize(30)),
          title: "Settings",
          textStyle: TextStyle(fontSize: SizeConfig.getScaledSize(12) ),
          // inactiveIcon: const Icon(
          //   Icons.shopping_cart_outlined,
          //   color: Colors.grey,
          // ),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),

        PersistentBottomNavBarItem(
          icon:  Icon(Icons.person,size:  SizeConfig.getScaledSize(30)),
          title: "Profile",
          textStyle: TextStyle(fontSize: SizeConfig.getScaledSize(12) ),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        )

      ];


    }

    PersistentTabController controller;
    double bottomNavHeight = screenWidth < 600 ? 56 : 150;
    controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      navBarHeight:  SizeConfig.getScaledSize(56),
      bottomScreenMargin: 4,
      padding: EdgeInsets.symmetric(vertical: 8),
      context,
      screens:_buildScreens(),
      items: _navBarsItems(),
      controller: controller,
      animationSettings: NavBarAnimationSettings(
        navBarItemAnimation: const ItemAnimationSettings(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation:  ScreenTransitionAnimationSettings(
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
      ),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),


      navBarStyle:
      NavBarStyle.style6,


    );
  }}

