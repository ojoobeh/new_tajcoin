import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/models/string_model.dart';

import '../../../../webazin/utilities.dart';

class OrderController extends GetxController {
  OrderSource orderSource = OrderSource(baseUrl: Core.uri);
  ScrollController scrollController = ScrollController();
  final isDone = false.obs;
  final isLoading = false.obs;
  final page = 0.obs;
  final isSearching = true.obs;

  final orderList = <DataOrder>[].obs;

  final editingControllerCardNumber = TextEditingController();
  final myController = TextEditingController();

  final cardNumber = ''.obs;
  final accountNumber = ''.obs;
  final shabaNumber = ''.obs;

  var user = DataUser().obs;
  final hidePassword = true.obs;
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final confirmPassword = "".obs;
  final imageAuthentication = "".obs;
  final smsSent = "".obs;
  final label = ''.obs;

  late GlobalKey<FormState> profileForm;

  final tecParamSearch = TextEditingController().obs;
  final status = <StringModel>[].obs;
  final type = <StringModel>[].obs;

  final selectStatus = StringModel().obs;
  final selectType = StringModel().obs;

  OrderController() {}

  Future refreshHome({bool showMessage = false, String? statusId}) async {
    printInfo();
    orderList.value.clear();
    isSearching.value = true;
    page.value = 0;
    orderList.clear();
    await getOrderList();
    user.value = Core.user;
  }

  @override
  void onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        if (orderList.value.length > 10) {
          getOrderList();
        }
      }
    });

    insertSpinner();
    await refreshHome();
    super.onInit();
  }

  void selectIndexStatus(StringModel stringModel) {
    selectStatus.value = stringModel;
    refreshHome();
    update();
  }

  void selectIndexType(StringModel stringModel) {
    selectType.value = stringModel;
    refreshHome();
    update();
  }

  Future resetSearch() async {
    tecParamSearch.value.text = "";
    update();
    refreshHome();
  }

  void insertSpinner() {
    status.add(StringModel(id: 1, title: "All".tr, param: ""));
    status.add(StringModel(id: 1, title: "New".tr, param: "new"));
    status.add(StringModel(id: 2, title: "Done".tr, param: "done"));
    status.add(StringModel(id: 1, title: "doing".tr, param: "process"));
    status.add(StringModel(id: 3, title: "Canceled".tr, param: "cancel"));
    selectStatus.value = status[0];

    type.add(StringModel(id: 1, title: "All".tr, param: ""));
    type.add(StringModel(id: 1, title: "Buy".tr, param: "buy"));
    type.add(StringModel(id: 1, title: "Sale".tr, param: "sell"));
    selectType.value = type[0];

    update();
  }

  Future<void> getOrderList() async {
    if (!isLoading.value) {
      try {
        isLoading(true);
        isDone(false);
        page.value++;

        orderSource.readHistory(
          currency: tecParamSearch.value.text,
          status: selectStatus.value.param!,
          type: selectType.value.param!,
          page: page.value,
          perPage: Core.perPage,
          onResponse: (response) {
            if (response.dataList!.isNotEmpty) {
              orderList.addAll(response.dataList ?? []);
              update();
            } else {
              isDone(true);
              update();
            }

            isSearching(false);
            isLoading(false);
          },
          onError: (errorResponse) {
            isSearching(false);
            isLoading(false);
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          },
          failure: (error) {
            isSearching(false);
            isLoading(false);
            snackbarRed(title: 'Error'.tr, subtitle: 'Error in receiving order list'.tr);
          },
        );
      } catch (e) {
        isDone(true);
      } finally {
      }
    }
  }

  void launchURL(String url) async => await launch(url);
}
