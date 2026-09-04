import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:webazin/utils/utils.dart';

const Color PRIMARY_COLOR = Colors.blueAccent;
const Color BACKGROUND_COLOR = Color(0xffE2E7F2);

class CustomBottomNavigationBar extends StatefulWidget {
  final Color? backgroundColor;
  final Color? itemColor;
  final List<CustomBottomNavigationItem>? children;
  final Function(int)? onChange;
  final int? currentIndex;

  CustomBottomNavigationBar({this.backgroundColor = BACKGROUND_COLOR, this.itemColor = PRIMARY_COLOR, this.currentIndex = 0, this.children, this.onChange});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 64,
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children!.map((item) {
          var color = item.color ?? widget.itemColor;
          var icon = item.icon;
          var isToast = item.isToast;
          var label = item.label;
          var message = item.message;
          int index = widget.children!.indexOf(item);
          return InkWell(
            onTap: () {
              !isToast!
                  ? _changeIndex(index)
                  : Fluttertoast.showToast(msg: message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);
              ;
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: MediaQuery.of(context).size.width / widget.children!.length - 4,
              padding: EdgeInsets.only(left: 1, right: 1),
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    icon!,
                    width: 24,
                    color: widget.currentIndex == index ? color : Colors.grey.shade500,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      label ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: widget.currentIndex == index ? color : Colors.grey.shade500, fontSize: 10, fontFamily: FontFamily.vazirBold),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final String? icon;
  final String? label;
  final String? message;
  final bool? isToast;
  final Color? color;

  CustomBottomNavigationItem({@required this.icon, this.message, this.isToast, @required this.label, this.color});
}
