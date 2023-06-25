import 'package:calories/models/custom_text.dart';
import 'package:flutter/material.dart';

ElevatedButton elevatedButton (String data,Color color, Function()  action,double value){
  return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              color
          ),
          elevation: MaterialStatePropertyAll(
            value
          ),
          overlayColor: const MaterialStatePropertyAll(
              Colors.transparent
          ),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(3))
            ),
          ),
          splashFactory: InkRipple.splashFactory,
          foregroundColor: const MaterialStatePropertyAll(
              Colors.cyan
          )
      ),
      onPressed: action ,
      child: CustomText(data, color: Colors.white,),
  );
}