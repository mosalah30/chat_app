import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



showIosProgressDialog(BuildContext context){
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CupertinoActivityIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}