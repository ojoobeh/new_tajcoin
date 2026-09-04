import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/page/call_page.dart';

import '../repository/pages_repository.dart';

class PagesController extends GetxController {
 late PageRepository _pageRepository;
  final title = ''.obs;
  final callPage = CallPage().obs;

  PagesController() {
    _pageRepository = PageRepository();
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
