// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:get/get.dart';
// import 'dart:convert';
//
// class SocketService {
//   static IO.Socket? socket;
//   static RxBool isConnected = false.obs;
//
//   static void connectToServer({required DataUser user}) {
//     try {
//       // قطع اتصال قبلی اگر وجود داره
//       if (socket != null && socket!.connected) {
//         socket!.disconnect();
//         socket!.dispose();
//       }
//
//       final serverUrl = '${Core.laravelBaseUrl2}:${Core.port}';
//       print('🔄 Connecting to: $serverUrl');
//
//       socket = IO.io(
//         serverUrl,
//         IO.OptionBuilder()
//             .setTransports(['websocket', 'polling'])
//             .setExtraHeaders({
//           'Authorization': 'Bearer ${user.apiToken}',
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         })
//             .setQuery({
//           'api_token': user.apiToken,
//           'EIO': '4'  // نسخه ۴ برای socket.io v3+
//         })
//             .setTimeout(30000)
//             .enableAutoConnect()
//             .build(),
//       );
//
//       // ================ رویدادهای اصلی ================
//       socket!.onConnect((_) {
//         print('✅ Socket connected');
//         isConnected.value = true;
//
//         // بعد از اتصال، اشتراک‌ها رو انجام بده
//         _subscribeToChannels(user);
//       });
//
//       socket!.onDisconnect((_) {
//         print('❌ Socket disconnected');
//         isConnected.value = false;
//       });
//
//       socket!.onConnectError((error) {
//         print('❌ Connection error: $error');
//         isConnected.value = false;
//       });
//
//       socket!.onError((error) {
//         print('❌ Socket error: $error');
//       });
//
//       // ================ کانال‌ها ================
//       _setupChannels();
//
//       // اتصال
//       socket!.connect();
//
//     } catch (e) {
//       print('❌ Error in connectToServer: $e');
//     }
//   }
//
//   // ================ تنظیم کانال‌ها ================
//   static void _setupChannels() {
//     // ۱. کانال balance update
//     socket!.on('BalanceUpdate', (data) {
//       print('📊 BalanceUpdate received: $data');
//       _handleBalanceUpdate(data);
//     });
//
//     // ۲. کانال ask/bid
//     socket!.on('AskBid', (data) {
//       print('📈 AskBid received');
//       _handleAskBid(data);
//     });
//
//     // ۳. کانال ticker
//     socket!.on('App\\Events\\Binance\\GetTicker', (data) {
//       print('📊 Ticker received');
//       _handleTicker(data);
//     });
//   }
//
//   // ================ اشتراک در کانال‌ها ================
//   static void _subscribeToChannels(DataUser user) {
//     try {
//       // ۱. اشتراک balance
//       final balanceChannel = '${Core.channel}_database_balance-Update-${user.id}';
//       socket!.emit('subscribe', balanceChannel);
//       print('✅ Subscribed to: $balanceChannel');
//
//       // ۲. اشتراک ask/bid
//       final askBidChannel = '${Core.channel}_database_ask-bid-channel-${selectMarketList.value.symbol}';
//       socket!.emit('subscribe', askBidChannel);
//       print('✅ Subscribed to: $askBidChannel');
//
//       // ۳. اشتراک ticker
//       final tickerChannel = '${Core.channel}_database_ticker-update-channels';
//       socket!.emit('subscribe', tickerChannel);
//       print('✅ Subscribed to: $tickerChannel');
//
//     } catch (e) {
//       print('❌ Error subscribing to channels: $e');
//     }
//   }
//
//   // ================ هندلر Balance Update ================
//   static void _handleBalanceUpdate(dynamic e) {
//     try {
//       if (e == null) return;
//
//       if (!e['isWallet']) {
//         // آپدیت بازار
//         if (e['id'] == selectMarketList.value.id) {
//           Map<String, dynamic> data = {
//             "id": e['id'],
//             "marketId": selectMarketList.value.id,
//             "icon": selectMarketList.value.icon,
//             "symbol": selectMarketList.value.symbol,
//             "price": selectMarketList.value.price,
//             "decimal": selectMarketList.value.decimal,
//             "percent": selectMarketList.value.percent,
//             "BalanceOne": e['BalanceOne'],
//             "BalanceTwo": e['BalanceTwo'],
//           };
//           DataMarket dataMarketList = DataMarket.fromMap(data);
//           selectCurrency(dataMarketList);
//           getOrder.value = false;
//           update();
//           updateAfterTrade(dataMarketList);
//           updateOrder(dataMarketList);
//         } else {
//           Map<String, dynamic> data = {
//             "id": selectMarketList.value.id,
//             "marketId": selectMarketList.value.id,
//             "icon": selectMarketList.value.icon,
//             "symbol": selectMarketList.value.symbol,
//             "price": selectMarketList.value.price,
//             "decimal": selectMarketList.value.decimal,
//             "percent": selectMarketList.value.percent,
//             "BalanceOne": selectMarketList.value.balanceOne,
//             "BalanceTwo": e['BalanceTwo'],
//           };
//           DataMarket dataMarketList = DataMarket.fromMap(data);
//           selectCurrency2(dataMarketList);
//           getOrder.value = false;
//           update();
//           updateAfterTrade(dataMarketList);
//         }
//       } else {
//         // آپدیت کیف پول
//         String currency = e['currency'];
//         String balanceOne = e['BalanceOne'].toString();
//         String irtPrice = e['irtPrice'].toString();
//
//         Get.find<AssetsController>().changeBalance(
//             currency,
//             double.parse(balanceOne),
//             double.parse(irtPrice),
//             0.0
//         );
//         Get.find<TradeController>().changeBalance(
//             currency,
//             double.parse(balanceOne),
//             double.parse(irtPrice)
//         );
//         Get.find<TradeDrawerController>().changeBalance(
//             currency,
//             double.parse(balanceOne),
//             double.parse(irtPrice)
//         );
//
//         print('💰 Balance updated: $balanceOne ::::: $irtPrice');
//       }
//     } catch (e) {
//       print('❌ Error handling BalanceUpdate: $e');
//     }
//   }
//
//   // ================ هندلر Ask/Bid ================
//   static void _handleAskBid(dynamic e) {
//     try {
//       if (e == null) return;
//
//       var asks = e['asks'];
//       var bids = e['bids'];
//
//       // پردازش bids
//       if (bids != null && bids is Map) {
//         List<SocketListUpDown> dd = [];
//         bids.forEach((key, value) {
//           double d = double.parse(key.toString());
//           String f = d.toString();
//           Map<String, dynamic> data = {
//             "price": f,
//             "percentage": value[0].toString(),
//             "volume": value.length > 1 ? value[1].toString() : "40",
//           };
//           dd.add(SocketListUpDown.fromJson(data));
//         });
//
//         List<SocketListUpDown> listReverse1 = dd.reversed.toList();
//         listDown.assignAll(listReverse1);
//         update();
//       }
//
//       // پردازش asks
//       if (asks != null && asks is Map) {
//         List<SocketListUpDown> dd = [];
//         asks.forEach((key, value) {
//           double d = double.parse(key.toString());
//           String f = d.toString();
//           Map<String, dynamic> data = {
//             "price": f,
//             "percentage": value[0].toString(),
//             "volume": value.length > 1 ? value[1].toString() : "0",
//           };
//           dd.add(SocketListUpDown.fromJson(data));
//         });
//         listUp.assignAll(dd);
//         update();
//       }
//     } catch (e) {
//       print('❌ Error handling AskBid: $e');
//     }
//   }
//
//   // ================ هندلر Ticker ================
//   static void _handleTicker(dynamic e) {
//     try {
//       if (e == null) return;
//
//       var yyy = jsonDecode(e);
//       CallMarketClose callMarketClose = CallMarketClose.fromJson(yyy);
//
//       String ss = selectMarketList.value.symbol;
//       if (callMarketClose.symbol == ss) {
//         close.value = double.parse(callMarketClose.close ?? '0')
//             .toStringAsFixed(int.parse(selectMarketList.value.decimal));
//         persentageValue.value = double.parse(callMarketClose.percentChange ?? '0');
//         update();
//       }
//     } catch (e) {
//       print('❌ Error handling Ticker: $e');
//     }
//   }
//
//   // ================ قطع اتصال ================
//   static void disconnect() {
//     if (socket != null) {
//       socket!.disconnect();
//       socket!.dispose();
//       socket = null;
//       isConnected.value = false;
//       print('🔌 Socket disconnected');
//     }
//   }
//
//   // ================ اشتراک مجدد ================
//   static void resubscribe(DataUser user) {
//     if (socket != null && socket!.connected) {
//       _subscribeToChannels(user);
//     }
//   }
// }