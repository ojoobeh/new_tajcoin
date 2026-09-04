import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/pages/assets/controllers/assets_controller.dart';
import 'package:webazin/utils/core.dart';

import '../../../../webazin/utilities.dart';

// ignore: deprecated_member_use
class BankCardController extends GetxController with SingleGetTickerProviderMixin {
  CardsSource cardsSource = CardsSource(baseUrl: Core.uri);
  BanksSource banksSource = BanksSource(baseUrl: Core.uri);
  UserSource userSource = UserSource(baseUrl: Core.uri);
  final cardsList = <DataCards>[].obs;
  final bankNameList = <DataBank>[].obs;
  final selectBankName = DataBank().obs;
  final editingControllerCardNumber = TextEditingController();
  final editingControllerAccountNumber = TextEditingController();
  final editingControllerShabaNumber = TextEditingController();

  final cardNumber = ''.obs;
  final accountNumber = ''.obs;
  final shabaNumber = ''.obs;
  final isLoading = false.obs;
  final cardListDone = false.obs;

  var user = DataUser().obs;
  final hidePassword = true.obs;
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final confirmPassword = "".obs;
  final imageAuthentication = "".obs;
  final smsSent = "".obs;
  final label = ''.obs;
  late TabController controller;
  late GlobalKey<FormState> profileForm;

  final orderList = <DataOrder>[].obs;
  final selectOrder = DataOrder().obs;

  BankCardController() {}

  @override
  void onInit() async {
    printInfo();
    controller = TabController(vsync: this, length: 2);
    cardsList.addAll(Core.user.cards ?? []);
    cardListDone(true);
    update();
    bankNameList.addAll(Core.bankList);
    selectBankName(bankNameList.first);

    setOrderList();
    user.value = Core.user;
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void selectIndexCategory(DataBank dataBankName) {
    selectBankName.value = dataBankName;
    update();
  }

  void selectIndexOrder(DataOrder dataOrder) {
    selectOrder.value = dataOrder;
    update();
  }

  Future<void> sendCard(final BuildContext context) async {
    if (!isLoading.value) {
      if (cardNumber.value.length == 16) {
        if (accountNumber.value.length > 3) {
          if (accountNumber.value.length != 24) {
            showLoading();
            cardsSource.createCard(
              dataCards: DataCards(
                bankName: selectBankName.value.name ?? '',
                cardNumber: cardNumber.value,
                accountNumber: accountNumber.value,
                sheba: shabaNumber.value,
              ),
              onResponse: (response) {
                getUser(
                  action: () {
                    snackbarGreen(title: 'Error'.tr, subtitle: response.message);
                    cardsList.clear();
                    Get.find<AssetsController>().cardList(Core.user.cards ?? []);
                    Get.find<AssetsController>().update();
                    cardsList.addAll(Core.user.cards ?? []);
                    cardListDone(true);
                    update();
                    controller.animateTo(1);
                    dismissLoading();
                  },
                );
              },
              onError: (onError) {
                snackbarRed(title: 'Error'.tr, subtitle: onError.message);
                dismissLoading();
              },
              failure: (error) {
                dismissLoading();
                snackbarRed(title: 'Error'.tr, subtitle: 'Error sending card information'.tr);
                dismissLoading();
              },
            );
          } else {
            snackbarRed(title: 'Error'.tr, subtitle: 'Shaba number is not valid'.tr);
          }
        } else {
          snackbarRed(title: 'Error'.tr, subtitle: 'The account number is not valid'.tr);
        }
      } else {
        snackbarRed(title: 'Error'.tr, subtitle: 'The card number is not valid'.tr);
      }

      if (cardsList.value != null && cardsList.value.length > 0) {
        editingControllerCardNumber.text = '';
        editingControllerAccountNumber.text = '';
        editingControllerShabaNumber.text = '';
      }
      update();
    }
  }

  void setOrderList() {
    List<DataOrder> list = [];

    orderList.assignAll(list);
    selectOrder.value = list[0];
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
