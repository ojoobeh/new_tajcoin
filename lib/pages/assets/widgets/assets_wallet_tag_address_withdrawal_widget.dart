import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../../trader/widgets/custom_form_fild.dart';
import '../controllers/assets_controller.dart';

class AssetsWalletTagAddressWithdrawalWidget extends StatelessWidget {
  final DataWallet dataAssets;

  const AssetsWalletTagAddressWithdrawalWidget(this.dataAssets);

//
  @override
  Widget build(final BuildContext context) {
    AssetsController controller = Get.find<AssetsController>();
    controller.tWallet.value.text = '';

    String tag = dataAssets.currency!.networks!.length > 0 ? dataAssets.currency?.networks![controller.selectNetworksIndex.value].tag ?? '' : '';
    return Container(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                children: <Widget>[
                  Text(
                    controller.selectTypeIndex.value != 1 ? 'Wallet address'.tr : 'User id'.tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.vazirBold,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: EdgeInsets.only(
                      right: 16,
                      left: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Get.theme.dividerColor.withOpacity(0.8),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Container(
                                height: 48,
                                child: Center(
                                  child: CustomFormFiled(
                                    controller.tWallet.value,
                                    hintText: controller.selectTypeIndex.value != 1 ? 'Wallet address'.tr : 'User id'.tr,
                                    focus: controller.focusWallet,
                                    keyboardType: controller.selectTypeIndex.value != 1 ? TextInputType.text : TextInputType.number,
                                    maxLength: 50,
                                    onChanged: (value) {
                                      // controller.setChangetPrice(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        controller.selectTypeIndex.value != 1
                            ? InkWell(
                                onTap: () => controller.scanWalletQrCode(context),
                                child: SvgPicture.asset(
                                  Assets.qrcode,
                                  width: 32,
                                  height: 32,
                                  color: Get.theme.dividerColor,
                                ),
                              ).marginOnly(right: 8)
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            controller.selectTypeIndex.value != 1 && tag != null && tag != 'null' && tag != ''
                ? Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Tag address'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.vazirBold,
                            color: Get.theme.dividerColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: EdgeInsets.only(
                            right: 16,
                            left: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Get.theme.dividerColor.withOpacity(0.8),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Container(
                                    height: 48,
                                    child: Center(
                                      child: CustomFormFiled(
                                        controller.tTag.value,
                                        hintText: 'Tag address'.tr,
                                        focus: controller.focusWallet,
                                        keyboardType: TextInputType.text,
                                        maxLength: 50,
                                        onChanged: (value) {
                                          // controller.setChangetPrice(value);
                                        },
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.scanTagQrCode(context),
                                child: SvgPicture.asset(
                                  Assets.qrcode,
                                  width: 32,
                                  height: 32,
                                  color: Get.theme.dividerColor,
                                ),
                              ).marginOnly(right: 8),
                              // InkWell(
                              //   onTap: () => controller.copyWallet(),
                              //   child: Container(
                              //     padding: EdgeInsets.all(10),
                              //     width: 50,
                              //     height: 40,
                              //     child: SvgPicture.asset(
                              //       Assets.paste,
                              //       color: Get.theme.dividerColor,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            controller.selectTypeIndex.value != 1
                ? Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Transfer fee'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.vazirBold,
                            color: Get.theme.dividerColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: EdgeInsets.only(
                            right: 16,
                            left: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Obx(() {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Get.theme.dividerColor.withOpacity(0.8),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                        child: Container(
                                      height: 48,
                                      child: Center(
                                        child: Text(
                                          double.parse(dataAssets.currency!.networks![controller.selectNetworksIndex.value].withdrawFee ?? '0').toStringAsFixed(int.parse(dataAssets.currency!.decimal??'0')) +
                                              ' ' +
                                              dataAssets.currency!.symbol!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Get.theme.dividerColor,
                                          ),
                                        ),
                                      ),
                                    )),
                                  );
                                }),
                              ),
                              // InkWell(
                              //   onTap: () => controller.copyWallet(),
                              //   child: Container(
                              //     padding: EdgeInsets.all(10),
                              //     width: 50,
                              //     height: 40,
                              //     child: SvgPicture.asset(
                              //       Assets.paste,
                              //       color: Get.theme.dividerColor,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
