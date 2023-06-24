import 'package:flutter/material.dart' ;
class CustomText extends Text{
  CustomText(
      String data, {super.key, color=Colors.black,fontSize=16.5,fontWeight=FontWeight.w400,textAlign=TextAlign.center,factor=1.0} ):
        super(
          data,
          textAlign:textAlign,
          textScaleFactor: factor,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight
          )
      );

}