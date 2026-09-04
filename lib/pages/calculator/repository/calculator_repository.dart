import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/currencies/currencies.dart';

import '../../../providers/laravel_provider.dart';

class CalculatorRepository {
 late LaravelApiClient _laravelApiClient;

  CalculatorRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }

 Future<CallCurrencies?> getCurrencies(int page, {String? search}) async {
   _laravelApiClient = Get.find<LaravelApiClient>();
   return _laravelApiClient.getCurrencies(page,search: search??'',perPage: 1000);
 }




}