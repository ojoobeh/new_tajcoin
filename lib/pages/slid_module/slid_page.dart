import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/slid_module/slid_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class slidPage extends GetView<slidController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('slid Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
