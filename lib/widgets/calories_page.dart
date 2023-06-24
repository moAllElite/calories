import 'dart:async';

import 'package:flutter/material.dart';
import 'package:calories/models/custom_text.dart';
import 'package:calories/models/sport_level.dart';
class CaloriesPage extends StatefulWidget{
  const CaloriesPage({super.key});
  @override
  State<StatefulWidget> createState()=>_CaloriesPage();

}
class _CaloriesPage extends State<CaloriesPage>{
  SportLevel _level=SportLevel.Modere;
  bool interrupteur=true;
  bool active=false;

  double height=100.0;
  @override
  Widget build(BuildContext context) {
    Color myColor = (interrupteur) ? Colors.pink : Colors.blue;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: (interrupteur) ?
          Theme
              .of(context)
              .colorScheme
              .inversePrimary : Colors.blue,
          title: CustomText("Calories ", color: Colors.white, fontSize: 30.0),
        ),
        body: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 1.1,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: CustomText(
                  "Remplissez tous les champs pour obtenir votre besoin journalier en calories",
                  fontSize: 15.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                      "Femme",
                      color: Colors.pink
                  ),
                  Switch(
                    thumbColor: const MaterialStatePropertyAll(
                        Colors.white
                    ),
                    value: interrupteur,
                    activeColor: Colors.blue,
                    inactiveTrackColor: Colors.pink,
                    onChanged: (bool value) =>
                        setState(() {
                          interrupteur = value;
                        }),
                  ),
                  CustomText(
                    "Homme",
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.1,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.7,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          showYear();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                (interrupteur == true) ? Colors.pink : Colors
                                    .blue
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
                        child: CustomText(
                          "Appuyez pour entrer votre âge",
                          color: Colors.white,
                        ),
                      ),
                      CustomText(
                        "Votre taille est de\t: ${height.toInt()} ",
                        color: myColor,
                      ),
                      Slider(
                          activeColor: (interrupteur) ? Colors.pink : Colors
                              .blue,
                          inactiveColor: Colors.grey[400],
                          value: height,
                          min: 100,
                          max: 200,
                          onChanged: (value) {
                            setState(() {
                              height = value;
                            });
                          }
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Entrer votre poids en kilo",
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            weight=value ;
                          });
                          showWeight();
                        },
                        keyboardType: TextInputType.number,
                      ),
                      CustomText(
                        "Quelle est votre activité sportive ?",
                        color: myColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              children: <Widget>[
                                Radio<SportLevel>(
                                  activeColor: myColor,
                                  value: SportLevel.Faible,
                                  groupValue: _level,
                                  onChanged: (SportLevel ?value) {
                                    setState(() {
                                      _level = value!;
                                    });
                                  },
                                ),
                                CustomText("Faible", color: myColor,
                                  textAlign: TextAlign.left,)
                              ]
                          ),
                          Column(
                            children: <Widget>[
                              Radio<SportLevel>(
                                activeColor: myColor,
                                value: SportLevel.Modere,
                                groupValue: _level,
                                onChanged: (SportLevel ? value) {
                                  setState(() {
                                    _level = value!;
                                  });
                                },
                              ),
                              CustomText("Moderé", color: myColor,
                                textAlign: TextAlign.left,)
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Radio<SportLevel>(
                                activeColor: myColor,
                                value: SportLevel.Forte,
                                groupValue: _level,
                                onChanged: (SportLevel ? value) {
                                  setState(() {
                                    _level = value!;
                                  });
                                },
                              ),
                              CustomText("Forte", color: myColor,
                                textAlign: TextAlign.left,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          (interrupteur) ? Colors.pink : Colors.blue
                      ),
                      elevation: const MaterialStatePropertyAll(
                          5.0
                      ),
                    ),
                    child: CustomText(
                      "Calculer", color: Colors.white, fontSize: 17.0,)),
              )
            ],
          ),
        )
    );
  }
  late String  weight;
  Future showWeight() async{
    return showDialog(
        context: context,
        builder:(context) {
          return AlertDialog(
            title: CustomText("Votre poids est de :\t $weight kilos"),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child:CustomText("Ok",color: Colors.blue[800],)
              ),
            ],
          ) ;
        },
    );
  }
  late String age;
  Future calculAge() async{
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(
            "votre age est de :\t ${
                 DateTime.now().year.toInt() - birthday.year.toInt()
            }",
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          actions: [
              TextButton(
                onPressed: ()=>Navigator.pop(context),
                child:CustomText("OK",color: Colors.blue[800],)
            )
          ],
        );
      },
    );
  }
  DateTime birthday=DateTime(2000);
  Future<DateTime?> showYear() async {
    return showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime(2000),
        firstDate: DateTime(1950),
        lastDate: DateTime(2022),
        onDatePickerModeChange: (value) {
          setState(() {
            birthday=value as DateTime;
          });
        },
    ).whenComplete(() => calculAge());
  }
}