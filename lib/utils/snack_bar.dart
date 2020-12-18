import 'package:flutter/material.dart';


  customSnackBar(text,themeData){
    return  SnackBar(
      content: new Text(
        text,
        style: themeData.textTheme.subtitle2.merge(TextStyle(color: themeData.colorScheme.onPrimary)),
      ),
      backgroundColor: themeData.colorScheme.error,
      behavior: SnackBarBehavior.floating,

    );
}
