import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/market/call_market_list.dart';
import 'package:webazin/webazin/data/models/market/call_market_order_list.dart';
import 'package:webazin/webazin/data/models/null/model_null_3.dart';

import '../../../providers/laravel_provider.dart';

class MarketAllOrderRepository {
  late LaravelApiClient _laravelApiClient;

  MarketAllOrderRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }
  Future<CallNull3?> cancelOrder(String orderId) {
    return _laravelApiClient.cancelOrder(orderId);
  }

  Future<CallMarketList?> getMarketList(int page, {String search=''}) async {
    this._laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.getMarketList(page, search: search);
  }

  Future<CallMarketOrderList?> getMarketOrderList(int page,String status,int marketId, ) async {
    this._laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.getMarketOrderList(page,status,marketId,perpage: 20);
  }

  Future<CallMarketOrderList?> getAllMarketOrderList(int page, String market, String status, String type, String marketStatus, int marketId) async {
    this._laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.getAllMarketOrderList(page, market, status, type, marketStatus, marketId, perpage: 20);
  }

}
