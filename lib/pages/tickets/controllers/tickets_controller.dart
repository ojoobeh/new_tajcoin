import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/core.dart';
import '../../../webazin/utilities.dart';

// ignore: deprecated_member_use
class TicketsController extends GetxController with SingleGetTickerProviderMixin {
  TicketSource ticketSource = TicketSource(baseUrl: Core.uri);
  OrderSource orderSource = OrderSource(baseUrl: Core.uri);

  late GlobalKey<FormState> profileForm;

  final orderList = <DataOrder>[].obs;
  final selectOrder = DataOrder().obs;
  final isSearching = true.obs;

  var user = DataUser().obs;
  final hidePassword = true.obs;
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final confirmPassword = "".obs;
  final imageAuthentication = "".obs;
  final smsSent = "".obs;
  final label = ''.obs;
  final subjectTicket = ''.obs;
  final messageTicket = ''.obs;
  late TabController controller;

  final isLoading = false.obs;
  final isDone = false.obs;
  final page = 0.obs;
  final ticketList = <DataTicket>[].obs;
  final ticketCategoryList = <DataTicketCategory>[].obs;
  final selectCategory = DataTicketCategory().obs;

  ScrollController scrollController = ScrollController();

  TicketsController() {
    updateJalaly();
  }

  @override
  void onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        if (ticketList.value.length > 10) {
          getTicketList();
        }
      }
    });

    controller = TabController(vsync: this, length: 2);

    await getTicketCategoryList(
      action: () {
        getOrderList(
          action: () {
            update();
            refreshList();
          },
        );
      },
    );

    user.value = Core.user;
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void selectIndexOrder(DataOrder dataOrder) {
    selectOrder.value = dataOrder;
    update();
  }

  Future<void> getOrderList({required VoidCallback action}) async {
    orderList.add(new DataOrder(
      id: 0,
      itemId: 0,
    ));
    selectOrder.value = orderList[0];
    update();
    orderSource.readHistory(
      onResponse: (response) {
        orderList.addAll(response.dataList ?? []);
        selectOrder.value = orderList[0];
        action();
      },
      onError: (errorResponse) {
        // snackbarOrange(title: 'Warning'.tr, subtitle: errorResponse.message);
        retRyDialog(action: () => getTicketCategoryList, description: errorResponse.message);
        action();
      },
      failure: (error) {
        snackbarRed(title: 'Error'.tr, subtitle: 'Error in receiving order list'.tr);
        action();
      },
    );
  }

  Future<void> refreshList() async {
    page.value = 0;
    isSearching.value = true;
    isLoading.value = false;
    ticketList.clear();
    ticketList.value = [];
    await getTicketList();
  }

  Future<void> getTicketCategoryList({required VoidCallback action}) async {
    ticketSource.readTicketCategory(
      onResponse: (response) {
        ticketCategoryList.assignAll(response.dataList ?? []);
        ticketCategoryList.length > 0 ? selectCategory.value = ticketCategoryList[0] : null;
        action();
      },
      onError: (errorResponse) {
        retRyDialog(action: () => getTicketCategoryList, description: errorResponse.message);
      },
      failure: (error) {
        retRyDialog(action: () => getTicketCategoryList, description: 'Error in receiving order categories'.tr);
      },
    );
  }

  void selectIndexCategory(DataTicketCategory dataTicketCategory) {
    selectCategory.value = dataTicketCategory;
    update();
  }

  Future<void> getTicketList() async {
    if (!isLoading.value) {
      try {
        isLoading.value = true;
        isDone.value = false;
        page.value++;
        ticketSource.read(
          page: page.value,
          perPage: Core.perPage,
          onResponse: (response) {
            if (response.dataList?.isNotEmpty ?? false) {
              ticketList.addAll(response.dataList ?? []);
            } else {
              isDone(true);
            }
            isSearching(false);
            isLoading(false);
            update();
          },
          onError: (errorResponse) {
            retRyDialog(action: getTicketList, description: errorResponse.message);
            isSearching(false);
            isLoading(false);
          },
          failure: (error) {
            retRyDialog(action: getTicketList, description: 'Error in receiving tickets'.tr);
            isSearching(false);
            isLoading(false);
          },
        );
      } catch (e) {
        isDone(true);
        isLoading(false);
      } finally {
        // isLoading.value = false;
      }
    }

    update();
  }

  Future<void> sendTicket() async {
    if (subjectTicket.value.length > 3) {
      if (messageTicket.value.length > 3) {
        showLoading();

        ticketSource.createTicket(
          categoryId: selectCategory.value.id ?? 0,
          subject: subjectTicket.value,
          message: messageTicket.value,
          onResponse: (response) {
            refreshList();
            controller.animateTo(1);
            dismissLoading();
          },
          onError: (errorResponse) {
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            dismissLoading();
          },
          failure: (error) {
            snackbarRed(title: 'Error'.tr, subtitle: 'Error sending ticket'.tr);
            dismissLoading();
          },
        );
      } else {
        snackbarRed(title: 'Error'.tr, subtitle: "The text is not valid".tr);
      }
    } else {
      snackbarRed(title: 'Error'.tr, subtitle: "The title is not valid".tr);
    }
  }

  void updateJalaly({bool showMessage = false}) {
    update();
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    this.imageAuthentication.value = image.path;
    update();
    return "";
  }

  void launchURL(String url) async => await launch(url);
}
