import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/size_config.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: SizeConfig.getScaledSize(56),
        title: Text('CartView',style: TextStyle(fontSize: SizeConfig.getScaledFontSize(22) ),),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CartView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
