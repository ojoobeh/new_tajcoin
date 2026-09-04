import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/page/call_page.dart';

import '../repository/pages_cuntact_us_repository.dart';

class PagesCuntactUsController extends GetxController {
  late PageCuntactUsRepository _pageRepository;
  final title = ''.obs;
  final callPage = CallPage().obs;

  PagesCuntactUsController() {
    _pageRepository = PageCuntactUsRepository();
  }

  @override
  void onInit() {
    title.value = Get.arguments;
    getPage();
    super.onInit();
  }

  Future getPage() async {
    callPage.value = (await _pageRepository.getCallPage(title.value))!;
    update();
  }
}
