import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../../trader/widgets/custom_form_fild.dart';
import '../controllers/assets_controller.dart';
import 'assets_copy_text_fild.dart';
import 'botton_sheet_help_widget.dart';

class AssetsWalletTagAddressWidget extends StatelessWidget {
  final DataWallet dataAssets;

  const AssetsWalletTagAddressWidget(this.dataAssets);

  @override
  Widget build(final BuildContext context) {
    AssetsController controller = Get.find<AssetsController>();

    return Obx(() {
      int ind = controller.selectNetworksIndex.value;
      Network networks = dataAssets.currency!.networks![ind];
      return Container(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              //Wallet Address
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Wallet address'.tr,
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
                              child: Center(
                                  child: Container(
                                height: 48,
                                child: Center(
                                  child: AssetsCopyTextFiled(
                                    param: dataAssets.currency!.networks![controller.selectNetworksIndex.value].address,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: QrImageView(
                        data: dataAssets.currency!.networks![controller.selectNetworksIndex.value].address!,
                        version: QrVersions.auto,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        size: 100.0,
                      ),
                    ),
                  ],
                ),
              ),

              networks.tag != null && networks.tag != 'null' && networks.tag != ""
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
                                    child: Center(
                                        child: Container(
                                      height: 48,
                                      child: Center(
                                        child: AssetsCopyTextFiled(
                                          param: dataAssets.currency!.networks![controller.selectNetworksIndex.value].tag,
                                        ),
                                      ),
                                    )),
                                  ),
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
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: QrImageView(
                              data: dataAssets.currency!.networks![controller.selectNetworksIndex.value].tag ?? '',
                              version: QrVersions.auto,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              size: 100.0,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.transparent,
                              size: 18,
                            ),
                          ),
                          Text(
                            'Transaction link(TxID)'.tr,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: FontFamily.vazirBold,
                              color: Get.theme.dividerColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                BottomSheetHelpWidget(
                                  "After depositing the currency to the wallet address, copy the Txhash from the source wallet and register it here.".tr,
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                Icons.info_outline,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
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
                                    controller.tTXID.value,
                                    hintText: 'Transaction link(TxID)'.tr,
                                    focus: controller.focusWallet,
                                    keyboardType: TextInputType.text,
                                    maxLength: 200,
                                    onChanged: (value) {
                                      // controller.setChangetPrice(value);
                                    },
                                  ),
                                ),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.scanTxidQrCode(context),
                            child: SvgPicture.asset(
                              Assets.qrcode,
                              width: 32,
                              height: 32,
                              color: Get.theme.dividerColor,
                            ),
                          ).marginOnly(right: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
