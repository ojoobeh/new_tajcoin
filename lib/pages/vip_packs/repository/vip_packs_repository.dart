import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/null/call_null.dart';
import 'package:webazin/webazin/data/models/vip/call_vip_packs.dart';

import '../../../providers/laravel_provider.dart';

class VipPacksRepository {
 late LaravelApiClient _laravelApiClient;

  VipPacksRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }


 Future<CallVipPacks?> getVipPacks() {
   _laravelApiClient = Get.find<LaravelApiClient>();
   return _laravelApiClient.getVipPacks();
 }


 Future<CallNull?> getBuyVip(int packId) {
   _laravelApiClient = Get.find<LaravelApiClient>();
   return _laravelApiClient.getBuyVip(packId);
 }





}