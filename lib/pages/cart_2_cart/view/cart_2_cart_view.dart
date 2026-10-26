import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/data/extensions/text_extension.dart';
import 'package:webazin/data/extensions/widget_extension.dart';
import 'package:webazin/pages/cart_2_cart/controller/cart_2_cart_controller.dart';
import 'package:webazin/utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/widgets/image.dart';

class Cart2CartView extends GetView<Cart2CartController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Card to card'.tr,
          style: TextStyle(fontFamily: FontFamily.vazirLight, color: Get.theme.dividerColor.withOpacity(0.8), fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: InkWell(
          onTap: back,
          child: Icon(Icons.arrow_back, color: context.theme.dividerColor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: [
              image(Assets.card,borderRadius: 16),
              Container(
                width: Get.width - 16,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 4),
                    Icon(Icons.arrow_back_ios,color: Colors.amber),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          Text('To top up your account, Shetab supports card-to-card deposits!'.tr).titleLarge(color: Colors.amber),
                          Container(
                            child: Text(
                              'In order to increase security, Shetab supports card-to-card deposits. Send a photo of the deposit slip to top up your account.'.tr,
                            ).titleMedium(),
                          ),

                          // )
                        ],
                      ),
                    ),
                    Icon(Icons.warning_amber_rounded, size: 64,color: Colors.amber),
                    SizedBox(width: 4),
                  ],
                ),
              ),

              Container(
                width: Get.width - 16,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 4),
                    Icon(Icons.arrow_back_ios,color: Colors.redAccent),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          Text('Note'.tr).titleLarge(color: Colors.redAccent),
                          Container(
                            child: Text(
                              'Deposits should only be made with cards and bank accounts in your name.'.tr,
                            ).titleMedium(),
                          ),

                          // )
                        ],
                      ),
                    ),
                    Icon(Icons.warning_amber_rounded, size: 64,color: Colors.redAccent),
                    SizedBox(width: 4),
                  ],
                ),
              ),//

              _item2(title: 'Card number'.tr,subTitle: '6219861483326914', icon: Icons.payment_outlined).paddingSymmetric(horizontal: 16),
              _item2(title: 'Account number'.tr,subTitle: '61182801510881601', icon: Icons.food_bank_outlined).paddingSymmetric(horizontal: 16),
              _item2(title: 'Shaba number'.tr,subTitle: 'IR78056061182801510881601', icon: Icons.share).paddingSymmetric(horizontal: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item2({
    required IconData icon,
    required String title,
    required String subTitle,
  }) => Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: context.theme.secondaryHeaderColor),
    padding: EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.green.withValues(alpha: 0.1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          child: Row(
            spacing: 4,
            children: [
              Icon(Icons.arrow_back_ios,color: Colors.green,size: 16,),
              Text('کپی').bodySmall(color: Colors.green),
              Icon(Icons.copy,color: Colors.green,size: 16,),
            ],
          ),
        ),
        Row(spacing: 8, children: [Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title),
            Text(subTitle).bodySmall(fontSize: 8),
          ],
        ), Icon(icon, size: 32,color: Colors.green,)]),
      ],
    ),
  ).onTap(() {
    copyText(subTitle);
    snackbarGreen(title: 'Success'.tr, subtitle: '$title با موفقیت ذخیره شد');
  },);
}
