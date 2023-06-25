import 'package:flutter/material.dart';

import '../models/custom_text.dart';
final snackBar =SnackBar(
  content: CustomText("Tous les champs ne sont pas remplis",textAlign: TextAlign.justify,color: Colors.white,fontSize: 15.0,),
  dismissDirection: DismissDirection.endToStart,
  backgroundColor: Colors.red[400],
  duration: const Duration(seconds: 7),
  elevation: 10.0,
  action: SnackBarAction(
    onPressed: (){

    }, label: 'Ok',backgroundColor: Colors.white,textColor: Colors.black,
  ),
);