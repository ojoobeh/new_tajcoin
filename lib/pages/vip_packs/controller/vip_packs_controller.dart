import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/null/call_null.dart';
import 'package:webazin/webazin/data/models/vip/call_vip_packs.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../../../utils/getMultipart.dart';
import '../../global_widgets/custom_loading.dart';
import '../../settings/controllers/settings_controller.dart';
import '../repository/vip_packs_repository.dart';

class VipPacksController extends GetxController {
  late VipPacksRepository _packsRepository;
  final isLoading = false.obs;
  final isDone = false.obs;
  final packsList = <DataVipPacks>[].obs;

  VipPacksController() {
    _packsRepository = VipPacksRepository();
  }

  @override
  void onInit() async {
    await getVipPacks();
    super.onInit();
  }

  Future<void> setLoading (final bool _isLoading) async {
    isLoading.value = _isLoading;
    update();
  }

  Future<void> getVipPacks() async {
    CallVipPacks? callVipPacks = await _packsRepository.getVipPacks();
    if (CallVipPacks != null) {
      if (callVipPacks!.code! == 1) {
        packsList.assignAll(callVipPacks.data!);
      }
      isDone.value = true;
      update();
    }
  }

  void getPackage(BuildContext context, DataVipPacks dataVipPacks) {
    Get.defaultDialog(
        title: "",
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        content: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Get.theme.scaffoldBackgroundColor,
          ),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Assets.logo),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Are you sure about buying a _days-day package at a price of _price Irt?".tr.replaceAll('_days', dataVipPacks.days.toString()).replaceAll('_price', getPrice(dataVipPacks.price!)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirMedium,
                      color: Get.theme.dividerColor,
                      fontSize: 14,
                    ),
                  ).marginOnly(top: 18),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    buyPackage(context, dataVipPacks);
                  },
                  child: Container(
                    height: 50,
                    width: Get.width / 2 - 50,
                    child: Center(
                      child: Text(
                        "Confirm".tr,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: Get.width / 2 - 50,
                    child: Center(
                      child: Text(
                        "Cancel".tr,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]);
  }

  Future<void> buyPackage(BuildContext context, DataVipPacks dataVipPacks) async {
    showDialog(
        context: context,
        builder: (final BuildContext context) {
          return CustomLoading(
            barrierDismissible: true,
          );
        });
    CallNull? callNull = await _packsRepository.getBuyVip(dataVipPacks.id!);
    if (callNull != null) {
      toast(callNull.message!);
      if (callNull.code == 1) {
        // await Get.find<AuthService>().getCurrentUser();
        await Get.find<SettingsController>().getUser(action: () {

        },);
        Get.back();
      }
    } else {}
    Get.back();
  }
}
