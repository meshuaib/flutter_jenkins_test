import 'package:flutter/material.dart';
import 'package:o2o/ui/widget/common/app_colors.dart';

/// Created by mdhasnain on 03 Mar, 2020
/// Email: md.hasnain@healthcare-tech.co.jp
///  
/// Purpose of the class:
/// 1. Custom appbar with custom navigation icon and custom menu icon
/// 2. More control over the app bar
/// 3. 

class TopBar extends StatelessWidget implements PreferredSizeWidget {

  TopBar({
    @required this.title,
    @required this.navigationIcon,
    this.iconColor = AppColors.colorBlue,
    this.background = Colors.white,
    this.menu,
    this.onTapNavigation,
    this.error = '',
    this.errorIcon = const Icon(Icons.warning, color: Colors.white,)
  }) : preferredSize = Size.fromHeight(80.0);
  final String title;
  final Widget navigationIcon;
  final Color iconColor;
  final Color background;
  final Widget menu;
  final Function onTapNavigation;
  final String error;
  final Icon errorIcon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: error.isEmpty? 50.0 : 84.0,
        width: MediaQuery.of(context).size.width,
        color: background,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        child:
//        Stack(
//          alignment: AlignmentDirectional.topStart,
//          children: <Widget>[
//            navigationIcon,
//            Stack(
//              alignment: AlignmentDirectional.topEnd,
//              children: <Widget>[
//                menu == null? Container() : menu,
//
//              ],
//            )
//          ],
//        ),
        Column(
          children: <Widget>[
            error.isEmpty? Container() : Container(
              color: Colors.redAccent,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  errorIcon,
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5),),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: InkWell(
                    child: navigationIcon,
                    onTap: () => onTapNavigation == null
                        ? Navigator.of(context).pop() : onTapNavigation(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: menu == null? Container(width: 50.0,) : menu,
                ),
              ],
            ),
          ],
        ),
//        Row(
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            InkWell(
//              child: navigationIcon,
//              onTap: () => onTapNavigation == null
//                  ? Navigator.of(context).pop() : onTapNavigation(),
//            ),
//            Padding(
//              padding: EdgeInsets.only(top: 5.0),
//              child: Text(
//                title,
//                style: TextStyle(
//                    fontSize: 16.0,
//                    fontWeight: FontWeight.w700
//                ),
//                textAlign: TextAlign.center,
//              ),
//            ),
//            menu == null? Container(width: 64.0,) : menu,
//          ],
//        ),
      ),
    );
  }

  @override
  final Size preferredSize;
}