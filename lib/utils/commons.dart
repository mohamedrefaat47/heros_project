import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:heros_demo/utils/app_colors.dart';
import 'package:toast/toast.dart';

class Commons {
  static void showError(
      {@required BuildContext context,
      @required String message,
      Function onTapOk}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                message,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: mainAppColor,
                    child: Text('Ok'),
                    textColor: Colors.white,
                    onPressed: () => onTapOk != null
                        ? onTapOk()
                        : Navigator.of(context).pop()),
              ],
            ));
  }

  static void showToast(
      {@required String message, @required BuildContext context, Color color}) {
    return Toast.show(
      message,
      context,
      backgroundColor: color == null ? mainAppColor : color,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }
}
