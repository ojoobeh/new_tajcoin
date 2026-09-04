import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/page/call_page.dart';

import '../../../providers/laravel_provider.dart';

class PageRepository {
 late LaravelApiClient _laravelApiClient;

  PageRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<CallPage?> getCallPage(String page) {
    return _laravelApiClient.getCallPage(page);
  }




}