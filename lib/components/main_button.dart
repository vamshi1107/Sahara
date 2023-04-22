import 'package:flutter/material.dart';

Widget MainButton(
    BuildContext context, String text, Function event, bool isDisabled) {
  return MaterialButton(
      onPressed: () {
        if (!isDisabled) {
          event();
        }
      },
      color: isDisabled ? Colors.black38 : Colors.black,
      disabledColor: Colors.black38,
      height: 60,
      minWidth: MediaQuery.of(context).size.width * 0.45,
      elevation: isDisabled ? 0 : 10.0,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ));
}
