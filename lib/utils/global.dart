part of 'core.dart';

String VERSIONNAME = "1.11";

Widget getArrowLeft({double width= 1.0, Color? color}) {
  String local = Get.locale!.languageCode;
  return local == 'fa'
      ? SvgPicture.asset(
          Assets.arrowLeft,
          width: width,
          color: color ?? Get.theme.dividerColor.withOpacity(0.7),
        )
      : SvgPicture.asset(
          Assets.arrowRight,
          width: width,
          color: color ?? Get.theme.dividerColor.withOpacity(0.7),
        );
}

String pPrice(String price, int num) {
  return double.parse(price).toStringAsFixed(num);
}

void getError(int errorNumber, {required String error, String position = "", bool showAllError= true, bool showError= false, stacktrace= ""}) {
  //30
  // String er = "";
  // showError ? er = error : "";
//
  if (showAllError) {
    snackbarRed(title: 'Error'.tr, subtitle: 'Communication error'.tr);
  }
  debugPrint('Error_On >> ${stacktrace}: $error');
}

void prt(String error, {name= "Error_Log"}) {
  //30
  developer.log(error, name: name);
}

Future<bool> checkInternet() async {
  try {
    Dio _dio = Dio();
    Get.log('starting services ...');

    try {
      Uri _uri = Uri.parse(
        Core.uri + "application/version",
      );

      // _dio = createDio();
      _dio = Dio();
      await _dio.getUri(_uri, options: Options(headers: {"Authorization": "dddddd"}));

      return true;
    } catch (e) {
      prt(
        e.toString(),
      );
      return false;
    }
  } catch (e) {
    prt(
      e.toString(),
    );
    return false;
  }
}

void dialog({
  required Widget child,
}) =>
    showDialog(
      context: Get.context!,
      builder: (final BuildContext context) => AlertDialog(
        content: child,
      ),
    );

void getUser({required VoidCallback action}) {
  UserSource userSource = UserSource(baseUrl: Core.uri);
  userSource.readUser(
    onResponse: (response) {
      Core.user = response.data!;
      action();
    },
    onError: (response) {
      retRyDialog(action: () => getUser(action: action), description: response.message);
      clearData();
      push(Splash2View());
    },
    failure: (error) {
      retRyDialog(action: () => getUser(action: action), description: 'Error in receiving information '.tr + ' User');
    },
  );
}

void getApplicationInfo({required VoidCallback action}) {
  ApplicationInfoSource applicationInfoSource = ApplicationInfoSource(baseUrl: Core.uri);
  applicationInfoSource.readApplicationInfo(
    onResponse: (response) {
      DataApplicationInfo? data = response.data!;
      Core.applicationInfo = data;
      action();
    },
    onError: (response) {
      retRyDialog(action: () => getApplicationInfo(action: action), description: response.message);
    },
    failure: (error) {
      retRyDialog(action: () => getApplicationInfo(action: action), description: 'Error in receiving information '.tr + ' Application '.tr);
    },
  );
}

void getCurrencies({required VoidCallback action}) {
  CurrencySource currencySource = CurrencySource(baseUrl: Core.uri);
  currencySource.read(
    onResponse: (response) {
      if (response.dataList?.isNotEmpty ?? false) {
        Core.currencies.addAll(response.dataList!);
      }
      action();
    },
    onError: (response) {
      retRyDialog(action: () => getCurrencies(action: action), description: response.message);
    },
    failure: (error) {
      retRyDialog(action: () => getCurrencies(action: action), description: 'Error in receiving information '.tr + ' Application '.tr);
    },
  );
}

Future<void> getBankNameList({required VoidCallback action}) async {
  BanksSource banksSource = BanksSource(baseUrl: Core.uri);
  banksSource.read(
    onResponse: (response) {
      if (response.dataList?.isNotEmpty ?? false) {
        Core.bankList.addAll(response.dataList!);
      }
      action();
    },
    onError: (response) {
      retRyDialog(action: () => getBankNameList(action: action), description: response.message);
    },
    failure: (error) {
      retRyDialog(action: () => getBankNameList(action: action), description: 'Error in receiving the bank list'.tr);
    },
  );
}

void retRyDialog({required VoidCallback action, required String description, String? title}) => showDialog(
      context: Get.context!,
      builder: (final BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(16)),
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      ),
                      color: Color(0xfff65656),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.warning_rounded,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title ?? 'Error'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.w400),
              ).paddingSymmetric(horizontal: 8),

              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Get.back();
                  action();
                },
                child: SvgPicture.asset(
                  Assets.refresh,
                  width: 32,
                  height: 32,
                  color: Color(0xfff65656),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );

Dio createDio() {
  var dio = Dio(BaseOptions(headers: {
    'Accept': "application/json",
    'Content-Type': 'application/json',
  }));

  // dio.options.connectTimeout = 1000;
  // dio.options.receiveTimeout = 5000;
  return dio;
}
