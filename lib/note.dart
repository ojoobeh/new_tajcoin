/*
Shimmer.fromColors(
          baseColor: Get.theme.cardColor,
          highlightColor: Get.theme.dividerColor.withOpacity(0.5),
          //////////////////////////////
   Container(
                 width: 24,
                 height: 24,
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey,
                  ),
               )

               //////////////////////////////////

     Shimmer.fromColors(
             baseColor: Get.theme.cardColor,
             highlightColor: Get.theme.dividerColor.withOpacity(0.5),
             child: Container(
               margin: const EdgeInsets.symmetric(vertical: 4),
               width: 80,
               height: 16,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(2),
                 color: Colors.grey,
               ),
             ),
                                                  )

 */

/*

  final isSearching = true.obs;


    void changeTab(String statusId) async {
       isSearching.value = true;

            }

     if (_callMarketOrderLIst != null) {
        if (_callMarketOrderLIst.code == "1") {
          isSearching.value = false;

        }
      }

              !controller.isSearching.value
              ? controller.marketOrderList.length > 0
              ? ListView.builder(itemBuilder: itemBuilder)
                  : Container()
                  : ListView.builder(itemBuilder: itemBuilder));

*/


/*
*
* Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Nothing found".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.vazirBold,
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ).marginOnly(bottom: 16),
                            InkWell(
                              onTap: () => controller.changeTab(controller.statusMarket.value),
                              child: Icon(
                                Icons.refresh,
                                size: 32,
                              ),
                            )
                          ],
                        )),
                      )
*
*
*
*
*
*
* */

/*

صفحه بازار حرفه ای قیمت ثابت خرید = > قیمت کل محدود به USDT و تعداد و قیمت ارز محدود به ارز و عدد ارسالی سمت سرور همان نمایش
صفحه بازار حرفه ای قیمت ثابت فروش = > قیمت کل محدود به USDT و تعداد  و قیمت ارز محدود به ارز و عدد ارسالی سمت سرور همان نمایش

صفحه بازار حرفه ای قیمت بازار خرید = > بودجه محدود به USDT عدد ارسالی سمت سرور همان نمایش
صفحه بازار حرفه ای قیمت بازار فروش = > بودجه محدود به ارز عدد ارسالی سمت سرور همان نمایش

صفحه مبادله سریع  خرید تعداد محدود به ارز عدد ارسالی سمت سرور همان نمایش
صفحه مبادله سریع  فروش تعداد محدود به ارز عدد ارسالی سمت سرور همان نمایش

صفحه کیف پول برداشت محدود به ارز

* */

