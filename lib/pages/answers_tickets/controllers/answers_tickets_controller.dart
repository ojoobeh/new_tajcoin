import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/pages/tickets/controllers/tickets_controller.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';

class AnswersTicketsController extends GetxController {
  TicketSource ticketSource = TicketSource(baseUrl: Core.uri);

  AnswersTicketsController() {
    updateJalaly();
  }

  final RxBool loadingSend = false.obs;
  Rx<DataUser> user = DataUser().obs;
  final RxBool hidePassword = true.obs;
  final RxString oldPassword = "".obs;
  final RxString newPassword = "".obs;
  final RxString confirmPassword = "".obs;
  final RxString imageAuthentication = "".obs;
  final RxString smsSent = "".obs;
  final RxString label = ''.obs;
  final FocusNode focusNodeMessage = FocusNode();

  String message = '';

  final Rx<DataTicket> dataTicket = DataTicket().obs;

  final RxList<DataAnswer> answersList = <DataAnswer>[].obs;
  final TextEditingController teMessage = TextEditingController(text: '');

  // ignore: avoid_positional_boolean_parameters

  @override
  void onInit() {
    printInfo();
    user.value = Core.user;
    dataTicket.value = Get.arguments;
    getDataTicket();
    debugPrint('OK');
    super.onInit();
  }

  Future<void> getAnswersList() async {
    answersList.value = dataTicket.value.answers!;

    update();
  }

  Future<void> getDataTicket() async {
    ticketSource.readById(
      ticketId: dataTicket.value.id ?? 0,
      onResponse: (response) {
        dataTicket.value = response.data!;
        answersList.value = (dataTicket.value.answers ?? []).reversed.toList();
        update();
      },
      onError: (errorResponse) {
        snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
      },
      failure: (error) {
        snackbarRed(title: 'Error'.tr, subtitle: 'Error receiving answers'.tr);
      },
    );
  }

  void updateJalaly({final bool? showMessage}) {
    // selectedDate.value = Jalali.now().toJalaliDateTime();
    update();
  }

  Future<void> sendTicket() async {
    loadingSend(true);
    update();
    ticketSource.createAnswer(
      ticketId: dataTicket.value.id ?? 0,
      message: message,
      onResponse: (response) {
        dataTicket.value = response.data!;
        answersList.value = (dataTicket.value.answers ?? []).reversed.toList();
        update();

        Get.find<TicketsController>().refreshList();

        loadingSend(false);
        teMessage.text = '';
        focusNodeMessage.requestFocus();
        update();
      },
      onError: (errorResponse) {
        snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
        loadingSend(false);
      },
      failure: (error) {
        snackbarRed(title: 'Error'.tr, subtitle: 'Error sending reply'.tr);
        loadingSend(false);
      },
    );
  }

  void launchURL(final String url) async => await launch(url);
}
