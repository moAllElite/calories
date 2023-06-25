import 'dart:io';
import 'package:flutter/material.dart' ;

Widget customText(String data, { color=Colors.black,fontSize=16.5,fontWeight=FontWeight.w400,textAlign=TextAlign.center,factor=1.0} ){
  if(Platform.isIOS){
    return DefaultTextStyle(
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color
      ),
      child: Text(data,textAlign: textAlign),
    );
  }else {
    return Text(
        data,
        textAlign: textAlign,
        textScaleFactor: factor,
        style: TextStyle(

            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight
        )
    );
  }
}