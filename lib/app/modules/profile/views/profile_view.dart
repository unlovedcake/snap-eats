import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/size_config.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final double screenWidth = MediaQuery.of(context).size.width;

    SizeConfig.init(context);
    print('PorfileView');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          toolbarHeight: SizeConfig.getSize(56),
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(fontSize: SizeConfig.getSize(22)),
          ),
        ),
        body: ListView(
          
          padding: EdgeInsets.all(8),
          children: [
            Text(
              'Hello World',
              style: TextStyle(fontSize: SizeConfig.getScaledFontSize(22)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.getSize(double.infinity),
                    height: SizeConfig.getHeight(150),
                    // 20% of the screen height
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: SizeConfig.getSize(150),
                          height: SizeConfig.getHeight(100),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: SizeConfig.getSize(150),
                          height: SizeConfig.getHeight(100),
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // 20% of the screen height
                      color: Colors.green,
                      child: Center(
                          child: Text('Container 2',
                              style: TextStyle(
                                  fontSize: SizeConfig.getScaledFontSize(12)))),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Colors.grey,
                      child: Center(
                          child: Text('Container 3',
                              style: TextStyle(
                                  fontSize: SizeConfig.getScaledFontSize(12)))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              color: Colors.cyan,
              child: Text(
                'Hello World',
                style: TextStyle(fontSize: SizeConfig.getScaledFontSize(8)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              color: Colors.yellow,
              child: Text(
                'Hello World',
                style: TextStyle(fontSize: SizeConfig.getScaledFontSize(8)),
              ),
            ),
          ],
        ));
  }
}
