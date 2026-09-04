import 'package:fluttertoast/fluttertoast.dart';
import 'package:webazin/webazin/data/dto/user.dart';

Future<DataUser?> getMultipartFile(
  DataUser user,
  String basePath,
  String imageAuthentication,
  String birthday,
) async {

}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}


