import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/remote_datasource/authenticationSource.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../widget/auth_custom_text_field_widget.dart';

class AuthenticationController extends GetxController {
  MediaSource mediaSource = MediaSource(baseUrl: Core.uri);
  UserSource userSource = UserSource(baseUrl: Core.uri);
  AuthenticationSource authenticationSource = AuthenticationSource(baseUrl: Core.uri);

  TextEditingController textEditingController = TextEditingController();

  var user = DataUser().obs;
  final hidePassword = true.obs;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final nationalCodeController = TextEditingController();
  final mobileCodeController = TextEditingController();
  final imageAuthentication = "".obs;
  final networkImageAuthentication = "".obs;
  final smsSent = "".obs;
  final selectedDate = ''.obs;
  final birthDay = ''.obs;
  final label = ''.obs;
  final isLoadingPhone = false.obs;
  final isLoadingVerify = false.obs;
  final isFataShow = false.obs;
  final isAcceptFata = false.obs;
  late GlobalKey<FormState> profileForm;

  AuthenticationController() {
    update();
  }

  @override
  void dispose() {
    super.dispose();
    dismissLoading();
  }

  @override
  void onInit() async {
    printInfo();
    user.value = Core.user;
    isFataShow.value = getBool(Core.isFataTrue);

    showLoading();
    getUser(
      action: () {
        birthDay.value = user.value.birthday ?? "".replaceAll("null", '');
        nationalCodeController.text = user.value.nationalCode ?? "";
        nameController.text = user.value.name ?? "";
        // imageAuthentication.value = user.value.docUrl ?? '';
        networkImageAuthentication.value = user.value.docUrl ?? '';
        dismissLoading();
        update();
      },
    );

    super.onInit();
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.imageAuthentication.value = image.path;
    }

    update();
  }

  Future takeImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    this.imageAuthentication.value = image.path;
    update();
    return "";
  }

  Future fataIsTrue(final BuildContext context) async {
    if (isAcceptFata.value) {
      setData(Core.isFataTrue, true);
      isFataShow.value = getBool(Core.isFataTrue);
      Navigator.pop(context);
    } else {
      // Navigator.pop(context);
      snackbarOrange(title: 'Warning'.tr, subtitle: "Please read the rules".tr);
    }
    update();
    return "";
  }

  Future setIsAcceptFata() async {
    isAcceptFata.value = !isAcceptFata.value;
    update();
  }

  void launchURL(String url) async => await launch(url);

  void saveProfileForm() async {
    if (imageAuthentication.value != null && imageAuthentication.value != "") {
      if (nameController.text  != "") {
        if (birthDay.value != null && birthDay.value != "") {
          if (nationalCodeController.text != "") {
            debugPrint(user.value.nationalCode);
            try {
              showLoading();
              mediaSource.create(
                file: File(imageAuthentication.value),
                nationalCode: nationalCodeController.text,
                birthday: birthDay.value,
                name: nameController.text,
                mobile: mobileCodeController.text ,
                action: () {
                  getUser(
                    action: () {
                      Get.back();
                      snackbarGreen(title: 'Success'.tr, subtitle: 'Documents have been sent successfully'.tr);
                      dismissLoading();
                    },
                  );
                },
                onError: (onError) {
                  snackbarRed(title: 'Error'.tr, subtitle: onError.message);
                  dismissLoading();
                },
                failure: (error) {
                  print(error);
                  dismissLoading();
                },
              );
            } catch (e) {
              dismissLoading();

            } finally {}
          } else {
            Fluttertoast.showToast(msg: "Enter the national code".tr, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(msg: "Enter your date of birth".tr, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(msg: "Enter your own name".tr, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(msg: "Choose your national card image".tr, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);
    }
  }

  void updateBirthday(String birthday) {
    birthDay.value = birthday;
    update();
  }

  void setLoadingPhone(final bool isProgress) {
    isLoadingPhone.value = isProgress;
    update();
  }

  void setLoadingVerify(final bool isProgress) {
    isLoadingVerify.value = isProgress;
    update();
  }

  void updatePassword() async {
    try {
      if (newPasswordController.text == confirmPasswordController.text) {
        showLoading();
        authenticationSource.updatePassword(
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text,
          onResponse: (response) {
            dismissLoading();
            DataUser user = response.data!;
            Core.user = user;
            Get.back();
            snackbarGreen(title: 'Success'.tr, subtitle: response.message);
          },
          onError: (errorResponse) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          },
          failure: (error) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: 'Error in password update'.tr);
          },
        );
      } else {
        Fluttertoast.showToast(
            msg: "The new password does not equal the repetition".tr, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);
      }
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {}
  }

  Future<void> verifyMobile(final BuildContext context) async {
    if (!isLoadingPhone.value) {
      setLoadingPhone(true);
      String mobile = mobileCodeController.text;

      showLoading();
      userSource.sendVerifyCode(
        dataUser: DataUser(
          mobile: mobile,
        ),
        onResponse: (response) {
          dismissLoading();
          Get.defaultDialog(
              title: "",
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              content: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Get.theme.scaffoldBackgroundColor,
                ),
                child: WillPopScope(
                  onWillPop: () async => false,
                  child: Container(
                    decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(Assets.logo),
                            ),
                          ),
                        ),
                        AuthCustomTextFieldWidget(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.start,
                          textEditingController: textEditingController,
                          validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                          hintText: "Verify code".tr,
                          labelText: "Verify code".tr,
                        ).marginOnly(top: 8),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          verifyCode(context);
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: isLoadingVerify.value
                                ? SpinKitWave(color: Colors.white, size: 24, type: SpinKitWaveType.center)
                                : Text(
                                    "Confirm".tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: FontFamily.vazirBold,
                                      color: Get.theme.dividerColor,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Cancel".tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.vazirBold,
                                color: Get.theme.dividerColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]);
        },
        onError: (onError) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: onError.message);
        },
        failure: (error) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + " User".tr);
        },
      );

      setLoadingPhone(false);
    }
  }

  Future<void> verifyCode(final BuildContext context) async {
    if (!isLoadingVerify.value) {
      setLoadingVerify(true);
      showLoading();
      authenticationSource.validateCode(
        code: textEditingController.text,
        onResponse: (onResponse) {
          getUser(action: () {
            snackbarGreen(title: 'Success'.tr, subtitle: onResponse.message);
            setLoadingVerify(false);
            dismissLoading();
            Navigator.pop(context);
            Navigator.pop(context);
          });
        },
        onError: (onError) {
          snackbarRed(title: 'Error'.tr, subtitle: onError.message);
          setLoadingVerify(false);
          dismissLoading();
        },
        failure: (error) {
          snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + " User".tr);
          setLoadingVerify(false);
          dismissLoading();
        },
      );
    }
  }

  void changeAcceptFata(final BuildContext context) {}
}
