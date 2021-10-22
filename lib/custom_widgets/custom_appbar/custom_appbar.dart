import 'package:flutter/material.dart';
import 'package:heros_demo/utils/app_colors.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBackBtn;
  final String title;
  final Widget leadingWidget;
  final Widget trailingWidget;
  final Function backButtonAction;

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  final Size preferredSize;

  const CustomAppbar(
      {Key key,
      this.scaffoldKey,
      this.hasBackBtn: false,
      this.leadingWidget,
      this.title,
      this.backButtonAction,
      this.preferredSize: const Size.fromHeight(60.0),
      this.trailingWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: mainAppColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadingWidget != null
              ? leadingWidget
              : hasBackBtn
                  ? Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: () => backButtonAction == null
                            ? Navigator.pop(context)
                            : backButtonAction,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: accentColor,
                          size: 18,
                        ),
                      ))
                  : Container(
                      width: 40,
                      height: 40,
                    ),
          Spacer(),
          Text(
            title,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          trailingWidget != null
              ? Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 5),
                  child: trailingWidget)
              : Container(
                  width: 40,
                ),
        ],
      ),
    );
  }
}
