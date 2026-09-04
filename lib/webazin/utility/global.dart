import 'dart:math';

import 'package:intl/intl.dart';

class Global {
  static int numberCountDecimal = 5;
  static int numberCountDecimal2 = 2;

  Global._();

  static const int firstPage = 1;
  static const int perPage = 100000;
  static const String userLogin = "userLogin";
  static const String token = "token";
  static const String deviceToken = "deviceToken";
  static const String isFataTrue = "isFataTrue";
  static const String isPortFolioTrue = "isPortFolioTrue";
  static String helperMarket = 'helper_market';
  static String helperHome = 'helper_home';
  static String helperAsset = 'helper_assets';
}

String getPrice(String price, {int limit= -1}) {
  String p3 = "0";
  if (price != null && price != "null" && price != "") {
    if (price.contains(",")) {
      p3 = price;
    } else {
      double l = double.parse(price);
      if (l == 0) {
        if (limit == 0) {
          p3 = '0';
        } else {
          p3 = "0.0";
        }
      } else if (l < 0) {
        p3 = price;
      } else {
        String pp = l.toString().split(".")[0];
        String pt = l.toString().split(".")[1];
        int pp2 = int.parse(pp);
        int pt2 = int.parse(pt);
        if (limit == 0) {
          String d = '';
          if (pp2 > 999) {
            var formatter = NumberFormat('#,###,000');
            d = formatter.format(pp2);
          } else {
            d = pp2.toString();
          }
          p3 = d;
        } else if (limit == -1) {
          if (pt2 > 0) {
            String d = '';
            if (pp2 > 999) {
              var formatter = NumberFormat('#,###,000');
              d = formatter.format(pp2);
            } else {
              d = pp2.toString();
            }

            p3 = d + ".${pt}";
          } else {
            String d = '';
            if (pp2 > 999) {
              var formatter = NumberFormat('#,###,000');
              d = formatter.format(pp2);
            } else {
              d = pp2.toString();
            }
            p3 = d;
          }
        } else {
          if (limit > pt.length) {
            limit = pt.length;
          }
          String d3 = pt.substring(0, limit);

          String d = '';
          if (pp2 > 999) {
            var formatter = NumberFormat('#,###,000');
            d = formatter.format(pp2);
          } else {
            d = pp2.toString();
          }
          p3 = d + ".${d3}";
        }
      }
    }

    // if (price.contains(",")) {
    //   p2 = price;
    // } else {
    //   if (price.contains(".")) {
    //     String pp = price.split(".")[0];
    //     String pt = price.split(".")[1];
    //     if (limit != -1) {
    //       if (limit > pt.length) {
    //         pt = pt.substring(0, pt.length - 1);
    //       } else {
    //         pt = pt.substring(0, limit);
    //       }
    //     }
    //
    //   }
    // }
  }

  // List d=p3.split(".");
  // String l1=d[0];
  // if(int.parse(l1.replaceAll(",", ""))<1000){
  //   String l2="";
  //   if(d.length>1){
  //     p4=(int.parse(l1)).toString()+"."+l2;
  //   }else{
  //     p4=(int.parse(l1)).toString();
  //   }
  //
  // }else{
  //   p4=p3;
  // }

  return p3;
}

//
String getCardNumber(String cardNumber) {
  String num = '';
  if (cardNumber.length == 16) {
    String n1 = cardNumber[0] + cardNumber[1] + cardNumber[2] + cardNumber[3];
    String n2 = cardNumber[4] + cardNumber[5] + cardNumber[6] + cardNumber[7];
    String n3 = cardNumber[8] + cardNumber[9] + cardNumber[10] + cardNumber[11];
    String n4 = cardNumber[12] + cardNumber[13] + cardNumber[14] + cardNumber[15];

    num = n1 + '  ' + n2 + '  ' + n3 + '  ' + n4;
  }
  return num;
}

String getSecurityEmail(String _email) {
  String res = '';
  List r = _email.split('@');
  String f = r[0];
  String t = f.substring(0, 2);
  String s = f.substring(f.length - 2, f.length);
  String star = '';
  List v = f.split('');
  for (int i = 2; i < v.length - 2; i++) {
    star = star + '*';
  }
  res = t + star + s + "@" + r[1];
  print("ddddddddddd" + res);

  return res;
}

double doubleFromJson(Map<String, dynamic> json, String attribute, {int decimal = 2, double defaultValue = 0.0}) {
  try {
    var param = json[attribute];
    if (json != null && json[attribute] != null) {
      if (param is double) {
        double b = param;
        return b;
      }
      if (param is int) {
        double p = double.parse(param.toString());
        return p;
      }
      if (param is String) {
        double p = double.parse(param);
        return p;
      }

      double t = double.parse(double.tryParse(json[attribute])!.toStringAsFixed(decimal));
      return t;
    }
    return defaultValue;
  } catch (e) {
    throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
  }
}

String pPrice(String price, int num) {
  return double.parse(price).toStringAsFixed(num);
}

double truncateToDecimalPlaces(num value, int fractionalDigits) => (value * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);

String gDouble(double num, {int decimal= -1}) {
  String res = sDouble(num.toString(), decimal: decimal);
  return res;
}

String sDouble(String num, {int decimal= -1}) {
  String p = num;
  String res = '';
  if (p.contains(".") && !p.contains('e')) {
    List t = p.split('.');
    String t1 = t[0];
    String t2 = t[1];
    String t3 = '0';

    if (decimal == -1) {
      res = p;
    } else {
      if (decimal == 0) {
        res = t1;
      } else {
        if (decimal > t2.length) {
          decimal = t2.length;
        }
        t3 = t2.substring(0, decimal);
        int d = int.parse(t3);
        if (d == 0) {
          t3 = "0";
          res = t1;
        } else {
          res = t1 + "." + t3;
        }
      }
    }
  } else {
    res = p;
  }
  return res;
}
