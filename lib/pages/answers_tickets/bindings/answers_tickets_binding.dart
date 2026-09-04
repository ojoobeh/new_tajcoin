import 'package:get/get.dart';
import 'package:webazin/pages/answers_tickets/controllers/answers_tickets_controller.dart';


class AnswersTicketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnswersTicketsController>(
      AnswersTicketsController.new,
    );
  }
}
