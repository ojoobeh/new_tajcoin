// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../../utils/helper.dart';
// import '../../../routes/app_routes.dart';
// import '../../../utils/assets.dart';
//
// import 'package:webazin/utils/utils.dart';
// import '../controllers/finger_print_controller.dart';
//
// class FingerPrintView extends GetView<FingerPrintController> {
//   @override
//   Widget build(final BuildContext context) {
//     return WillPopScope(
//       onWillPop: Helper().onWillPop,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           backgroundColor: Get.theme.scaffoldBackgroundColor,
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Center(
//                       child: Text(
//                         'Fingerprint login'.tr,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: FontFamily.vazirBold,
//                           color: Get.theme.dividerColor.withOpacity(0.8),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         controller.authenticate();
//                       },
//                       child: SvgPicture.asset(
//                         Assets.fingerprint,
//                         width: 94,
//                         height: 94,
//                         color: AppColors.orangeColor,
//                       ).marginSymmetric(vertical: 32),
//                     ),
//                     Text(
//                       'Click on the fingerprint to log in'.tr,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: FontFamily.vazirBold,
//                         color: Get.theme.dividerColor.withOpacity(0.8),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () => Get.toNamed(Routes.LOGIN),
//                 child: Center(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width / 2,
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color:  AppColors.orangeColor,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: AppColors.orangeColor,
//                           width: 1,
//                         )),
//                     child: Center(
//                       child: Text(
//                         'Enter with username and password'.tr,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontFamily: FontFamily.vazirBold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ).marginOnly(top: 36, bottom: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
