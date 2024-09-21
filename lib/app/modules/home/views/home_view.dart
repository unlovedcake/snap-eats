import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snap_eats/app/helper/my_logger.dart';
import 'package:snap_eats/app/routes/app_pages.dart';

import '../../../helper/size_config.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    MyLogger.printMessage(
        'APPCHECKTOKEN:' + const String.fromEnvironment('APP_CHECK_TOKEN'));
    print('APPCHECKTOKEN:' + const String.fromEnvironment('MY_OTHER_VAR'));
    MyLogger.printMessage('Build Home Page');
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: SizeConfig.getScaledSize(56),
        title: Text(
          'HomeView',
          style: TextStyle(fontSize: SizeConfig.getScaledFontSize(22)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              onPressed: () => throw Exception(),
              child: const Text("Throw Test Exception"),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                controller.addTodo();
              },
              child: Text("Add Todo")),
          ElevatedButton(
              onPressed: () {
                controller.payMongo();
              },
              child: Text("Gcash")),
          ElevatedButton(
              onPressed: () {
                controller.createTodo();
              },
              child: Text("Crate Todo")),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(AppPages.WEBVIEW);
              },
              child: Text("WebView")),
        ],
      ),
    );
  }
}
