import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/dto/user.dart';
import 'package:webazin/webazin/data/remote_datasource/user_source.dart';

import '../../../utils/ui.dart';

class ProfileController extends GetxController {
  var user = DataUser().obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final hidePassword = true.obs;
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final confirmPassword = "".obs;
  final smsSent = "".obs;
  late GlobalKey<FormState> profileForm;

  late final selectedThemeMode = ThemeMode.light.obs;
  late GetStorage _box;

  ProfileController() {
    _box = GetStorage();
  }

  @override
  void onInit() {
    initThemeMode();
    user.value = Core.user;
    super.onInit();
  }

  Future refreshProfile({bool showMessage = false}) async {
    // await getUser();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of faqs refreshed successfully".tr));
    }
  }

  void saveProfileForm() async {
    if (profileForm.currentState!.validate()) {
      try {
        profileForm.currentState!.save();

        // Core.user =
        // (await _userRepository.update(user.value))!;
        // Get.back();

        // user.value.password = newPassword.value == confirmPassword.value ? newPassword.value : null;
        // await _userRepository.sendCodeToPhone();
        // Get.bottomSheet(
        //   PhoneVerificationBottomSheetWidget(),
        //   isScrollControlled: false,
        // );
      } catch (e) {
        // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {}
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "There are errors in some fields please correct them!".tr));
    }
  }

  Future<void> verifyPhone() async {
    try {
      // user.value = (await _userRepository.update(user.value))!;
      Core.user = user.value;
      Get.back();
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Profile saved successfully".tr));
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  UserSource userSource = UserSource(baseUrl: Core.uri);

  Future getUser() async {
    userSource.readUser(
      onResponse: (response) {
        user.value = response.dataList!.first;
      },
      onError: (onError) {},
      failure: (error) {},
    );
  }

  void initThemeMode() {
    String? _themeMode = _box.read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        selectedThemeMode.value = ThemeMode.light;
        break;
      case 'ThemeMode.dark':
        selectedThemeMode.value = ThemeMode.dark;
        break;
      case 'ThemeMode.system':
        selectedThemeMode.value = ThemeMode.system;
        break;
      default:
        selectedThemeMode.value = ThemeMode.dark;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    selectedThemeMode.value = themeMode;
    if (themeMode == ThemeMode.dark) {
      //Get.rootController.setTheme(Get.find<SettingsService>().getDarkTheme());
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(),
      );
    } else {
      //Get.rootController.setTheme(Get.find<SettingsService>().getLightTheme());
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(),
      );
    }
    _box.write('theme_mode', themeMode.toString());
    Get.rootController.refresh();
  }
}
