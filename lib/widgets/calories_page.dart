import 'package:calories/widgets/elevated_button.dart';
import 'package:calories/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import '../models/custom_text.dart';
import '../models/sport_level.dart';
class CaloriesPage extends StatefulWidget{
  const CaloriesPage({super.key});
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: (genre) ?
          Theme
              .of(context)
              .colorScheme
              .inversePrimary : Colors.blue,
          title: CustomText("Calories ", color: Colors.white, fontSize: 30.0),
        ),
        body: SingleChildScrollView(
          padding:const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              padding(),
              CustomText(
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
                          CustomText(
                              "Femme",
                              color: Colors.pink
                          ),
                          Switch(
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
                          ),
                          CustomText(
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
                      CustomText("Votre taille est de\t: ${height.toInt()} cm",
                        color: setColor(),
                      ),
                      Slider(
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
                      ),
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      CustomText(
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
                                CustomText("Faible", color: setColor() , textAlign: TextAlign.left,)
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
                              CustomText("Moderé", color: setColor(), textAlign: TextAlign.left,)
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
                              CustomText("Forte", color: setColor() , textAlign: TextAlign.left,)
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
        )
    );
  }
    Color setColor()  {
    if (genre) {
    return   Colors.pink ;
    }{
     return  Colors.blue;
    }
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
        title:CustomText('Votre besoin en calories ',color: setColor(),fontWeight: FontWeight.w600) ,
        contentPadding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2)
        ),
        children:<Widget> [
          padding(),
          CustomText("Votre besoin en calories est de : $calorieBase "),
          padding(),
          CustomText("Votre besoin avec activité sportive est de : $calorieActivite "),
          elevatedButton(
              "ok".toUpperCase(),
              setColor(),
              (){
                Navigator.of(buildContext).pop();
              },
            10
          )
        ],
      );
  });
  }


}