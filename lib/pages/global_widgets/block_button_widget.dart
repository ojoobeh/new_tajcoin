import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockButtonWidget extends StatelessWidget {
  BlockButtonWidget({this.color, this.text, this.onPressed});

  final Color? color;
  final Widget? text;
  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 250,
      decoration: this.onPressed != null
          ? BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(color: this.color!.withOpacity(0.3), blurRadius: 40, offset: Offset(0, 15)),
                BoxShadow(color: this.color!.withOpacity(0.2), blurRadius: 13, offset: Offset(0, 3))
              ],
              // borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: MaterialButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: this.color,
        disabledElevation: 0,
        disabledColor: Get.theme.focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: this.text,
        elevation: 0,
      ),
    );
  }
}
