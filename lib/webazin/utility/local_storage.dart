import 'package:get_storage/get_storage.dart';
import 'package:webazin/webazin/utility/global.dart';

void setData(final String key, final dynamic value) => GetStorage().write(key, value);

void setLogin(final bool isLogin) => GetStorage().write(Global.userLogin, isLogin);

void setToken(final String token) => GetStorage().write(Global.token, token);

int? getInt(final String key) => GetStorage().read(key);

String? getString(final String key) => GetStorage().read(key);

String getToken() => GetStorage().read(Global.token) ?? '';

bool getBool(final String key) => GetStorage().read(key) ?? false;

bool isLogin() => GetStorage().read(Global.userLogin) ?? false;

double? getDouble(final String key) => GetStorage().read(key);

dynamic getData(final String key) => GetStorage().read(key);

void clearData() => GetStorage().erase();
