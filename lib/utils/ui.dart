
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';

class Ui {
  // ignore: deprecated_member_use
  static GetBar SuccessSnackBar({String title = 'Success', String? message}) {
    Get.log("[$title] $message");
    // ignore: deprecated_member_use
    return GetBar(

      messageText: Text(message!,
          style: TextStyle(color: Get.theme.primaryColor)),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.green,
      icon: Icon(Icons.check_circle_outline,
          size: 22, color: Get.theme.primaryColor),
      padding: EdgeInsets.only(left: 10, top: 18,bottom: 18),
      borderRadius: 8,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: Duration(seconds: 3),
    );
  }

  // ignore: deprecated_member_use
  static GetBar ErrorSnackBar({String title = 'Error', String? message}) {
    Get.log("[$title] $message", isError: true);
    // ignore: deprecated_member_use
    return GetBar(
      titleText: Text(title.tr,
          style: TextStyle(color: Get.theme.primaryColor)),
      messageText: Text(message!,
          style: TextStyle(color: Get.theme.primaryColor)),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline,
          size: 32, color: Get.theme.primaryColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  // ignore: deprecated_member_use
  static GetBar defaultSnackBar({String title = 'Alert', String? message}) {
    Get.log("[$title] $message", isError: false);
    // ignore: deprecated_member_use
    return GetBar(
      titleText: Text(title.tr,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message!,
          style: Get.textTheme.labelSmall!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded,
          size: 32, color: Get.theme.hintColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  // ignore: deprecated_member_use
  static GetBar notificationSnackBar(
      {String title = 'Notification', String? message}) {
    Get.log("[$title] $message", isError: false);
    // ignore: deprecated_member_use
    return GetBar(
      titleText: Text(title.tr,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message!,
          style: Get.textTheme.labelSmall!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon:
          Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
    }));
    return list;
  }

  /*
  *  Setting setting = Setting();
    setting.appName = "TajCoin";
    setting.enableStripe = false;
    setting.defaultTax = "4";
    setting.fcmKey =
        "AAAAHLvC32U:APA91bH-doaq_JvjEMfeQs6MyvSTtHCfx_GCDp5yqfttKskmpa8dfO3vOMKvhTIwzGnce3IPe0A0N1EuRrwvHGYlvcNIRLTsLihWI-fG20dLcXZkGu-rsb3_I6UktF2jKij9jLoKNP0y";
    setting.enablePaypal = false;
    setting.defaultTheme = "light";
    setting.googleMapsKey = "AIzaSyBTPr0z_-2Oq9vfE9gPZIxZxLBUb8jzyow";
    setting.mobileLanguage = "en";
    setting.appVersion = "1.0.0";
    setting.enableVersion = true;
    setting.currencyRight = true;
    setting.defaultCurrencyDecimalDigits = 0;*/

  static Widget getPrice(double myPrice,
      {TextStyle? style, String zeroPlaceholder = '-', String? unit}) {
    if (style != null) {
      style = style.merge(TextStyle(fontSize: style.fontSize! + 2));
    }
    try {
      if (myPrice == 0) {
        return Text('-', style: style ?? Get.textTheme.titleMedium);
      }
      return RichText(
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 1,
        text: TextSpan(
          text: myPrice.toStringAsFixed(0),
          style: style ?? Get.textTheme.titleMedium,
          children: <TextSpan>[
            TextSpan(
                text: ' Irt '.tr,
                style: getPriceStyle(style!)),
            if (unit != null)
              TextSpan(
                  text: " " + unit + " ", style: getPriceStyle(style)),
          ],
        ),
      );
    } catch (e) {
      return Text('');
    }
  }

  static TextStyle getPriceStyle(TextStyle style) {
    if (style == null) {
      return Get.textTheme.titleMedium!.merge(
        TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: Get.textTheme.titleMedium!.fontSize! - 4),
      );
    } else {
      return style.merge(
          TextStyle(fontWeight: FontWeight.w300, fontSize: style.fontSize! - 4));
    }
  }

  static BoxDecoration getBoxDecoration(
      {Color? color, double? radius, Border? border, Gradient? gradient}) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Get.theme.focusColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5)),
      ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static InputDecoration getInputDecoration(
      {String hintText = '',
      String? errorText,
      IconData? iconData,
      double? sizeIconData= 20,
      Color? colorIconData,
      Widget? suffixIcon,
      Widget? suffix}) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: TextStyle(
        color: Color.fromRGBO(160, 160, 160, 1.0),
      ),
      prefixIcon: iconData != null
          ? Icon(
              iconData,
              color: colorIconData ?? Get.theme.dividerColor.withOpacity(0.5),
              size: sizeIconData,
            ).marginOnly(right: 8, left: 8)
          : SizedBox(),
      prefixIconConstraints: iconData != null
          ? BoxConstraints.expand(width: 38, height: 38)
          : BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.all(0),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }


  static BoxFit getBoxFit(String boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }


  static AlignmentDirectional getAlignmentDirectional(
      String alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static CrossAxisAlignment getCrossAxisAlignment(String textPosition) {
    switch (textPosition) {
      case 'top_start':
        return CrossAxisAlignment.start;
      case 'top_center':
        return CrossAxisAlignment.center;
      case 'top_end':
        return CrossAxisAlignment.end;
      case 'center_start':
        return CrossAxisAlignment.center;
      case 'center':
        return CrossAxisAlignment.center;
      case 'center_end':
        return CrossAxisAlignment.center;
      case 'bottom_start':
        return CrossAxisAlignment.start;
      case 'bottom_center':
        return CrossAxisAlignment.center;
      case 'bottom_end':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }
}
