import 'package:flutter/material.dart';
import 'package:heros_demo/utils/app_colors.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  const PageContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: mainAppColor,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: child,
          ),
        ));
  }
}
