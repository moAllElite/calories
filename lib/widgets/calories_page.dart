import 'package:calories/widgets/elevated_button.dart';
import 'package:calories/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';
import '../models/sport_level.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class CaloriesPage extends StatefulWidget{
  const CaloriesPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState()=>_CaloriesPage();

}
class _CaloriesPage extends State<CaloriesPage>{
  /*
   * variables
   */
  late double age=0;
  bool genre=true;
  bool active=false;
  double height=100.0;
  late double weight=0;
  int calorieBase=0;
  int calorieActivite=0;
  SportLevel _level=SportLevel.modere;
  final fieldText = TextEditingController();
  //clear the weight field
  void clearText() {
    fieldText.clear();
  }
  //reset slider
  void _reset(){
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => const CaloriesPage(),
      )
    );
  }
  @override
  Widget build(BuildContext context) {

    return (Platform.isIOS)?
        CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: setColor(),
              middle: customText("Calories"),

            ),
            child:body()
        )
       :Scaffold(
        appBar: AppBar(
              backgroundColor: (genre) ?
              Theme
                .of(context)
                .colorScheme
                .inversePrimary : Colors.blue,
              title: customText("Calories ", color: Colors.white, fontSize: 30.0),
        ),
        body:body()
    );
  }
    Color setColor()  {
    if (genre) {
    return   Colors.pink ;
    }{
     return  Colors.blue;
    }
  }
  Widget switchByPlateform(){
    if(Platform.isIOS){
      return CupertinoSwitch(
        value: genre,
        activeColor: Colors.blue,
        onChanged: (bool value){
          setState(() {
            genre=value;
          });
        },
      );
    }else{
      return Switch(
        thumbColor: const MaterialStatePropertyAll(
            Colors.white
        ),
        value: genre,
        activeColor: Colors.blue,
        inactiveTrackColor: Colors.pink,
        onChanged: (bool value) =>
            setState(() {
              genre = value;
            }),
      );
    }
  }

  Widget sliderByPlateform(){
    if(Platform.isIOS){
      return CupertinoSlider(
        activeColor: setColor(),
        min: 100,
        max: 215,
        value: height,
        onChanged: (double value){
          setState(() {
            height=value;
          });
        },
      );
    }else{
      return  Slider(
          activeColor: setColor(),
          inactiveColor: Colors.grey[400],
          value: height,
          min: 100,
          max: 215,

          onChanged: (value) {
            setState(() {
              height = value;
            });
          }
      );
    }
  }

  Widget body(){
    return SingleChildScrollView(
      padding:const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          padding(),
          customText(
            "Remplissez tous les champs pour obtenir votre besoin journalier en calories",
            fontSize: 15.0,
          ),
          padding(),
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 1.1,
            height: MediaQuery
                .of(context)
                .size
                .height / 1.7,
            child:   Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customText(
                          "Femme",
                          color: Colors.pink
                      ),
                      switchByPlateform(),
                      customText(
                        "Homme",
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  elevatedButton(
                      (age==0 )?
                      "Appuyez pour entrer votre âge":"Votre âge est de : ${age.toInt()} ans",
                      setColor(), (){showYear();}, 0
                  ),
                  customText("Votre taille est de\t: ${height.toInt()} cm",
                    color: setColor(),
                  ),
                 sliderByPlateform(),
                  Container(
                    margin: const EdgeInsets.only(top: 5,bottom: 15),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Entrer votre poids en kg",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          weight=double.tryParse(value)!;
                        });
                      },
                      controller: fieldText,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  customText(
                    "Quelle est votre activité sportive ?",
                    color: setColor(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                          children: <Widget>[
                            Radio(
                                activeColor: setColor(),
                                value: SportLevel.faible,
                                groupValue: _level,
                                onChanged: (SportLevel ? value) {
                                  setState(() {
                                    _level = value!;
                                  });
                                }
                            ),
                            customText("Faible", color: setColor() , textAlign: TextAlign.left,)
                          ]
                      ),
                      Column(
                        children: <Widget>[
                          Radio<SportLevel>(
                            activeColor: setColor(),
                            value: SportLevel.modere,
                            groupValue: _level,
                            onChanged: (SportLevel ? value) {
                              setState(() {
                                _level = value!;
                              });
                            },
                          ),
                          customText("Moderé", color: setColor(), textAlign: TextAlign.left,)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Radio<SportLevel>(
                            activeColor:setColor(),
                            value: SportLevel.forte,
                            groupValue: _level,
                            onChanged: (SportLevel ? value) {
                              setState(() {
                                _level = value!;
                              });
                            },
                          ),
                          customText("Forte", color: setColor() , textAlign: TextAlign.left,)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          padding(),
          elevatedButton(
              "Calculer",
              setColor(),
              calculerNombreDeCalories,
              5.0),
        ],
      ),
    );
  }

  Future  showYear() async {
    final  choix = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (choix != null) {
      var difference = DateTime
          .now()
          .difference(choix);

      var day=difference.inDays;
      var years=(day/365);

      setState(() {
        age=years;
      });
    }
    return choix;
  }
  Padding padding (){
    return const Padding(padding: EdgeInsets.only(top: 20));
  }
  void  calculerNombreDeCalories() async {
    if(age.toInt() != 0  && weight != 0  ){
        if(genre){
          calorieBase=(66.4730 + (13.7516 * weight) + (5.0033 * height) -(6.755 * age)).toInt();
        }else{
          calorieBase=(66.0955 + (9.5634 * weight) + (1.8496 * height) -(4.6756 * age)).toInt();
        }
        switch(_level.index){
          case 0:
            calorieActivite = (calorieBase * 1.2).toInt();break;
          case 1:
            calorieActivite = (calorieBase * 1.5).toInt();break;
          case 2:
            calorieActivite = (calorieBase * 1.8).toInt();break;
          default:
            calorieActivite = calorieBase; break;
        }
        setState(() {
          _showMyDialog();
          age=0;
          clearText;
        });
    }else{
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<void> _showMyDialog() async{
    return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext buildContext){
      return SimpleDialog(
        title:customText('Votre besoin en calories ',color: setColor(),fontWeight: FontWeight.w600) ,
        contentPadding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2)
        ),
        children:<Widget> [
          padding(),
          customText("Votre besoin en calories est de : $calorieBase "),
          padding(),
          customText("Votre besoin avec activité sportive est de : $calorieActivite "),
          elevatedButton(
              "ok".toUpperCase(),
              setColor(),
              (){
                Navigator.of(buildContext).pop();
               _reset();
                age = 0;
                clearText();
              },
            10,
          )
        ],
      );
  });
  }


}