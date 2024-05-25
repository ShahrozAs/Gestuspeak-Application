
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void displayMessageToUser(String message,BuildContext context){
showDialog(context: context, builder: (context) {
  return Center(child: Container(
    width: 400,
    height: 300,
    child: AlertDialog(content: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        
        Align(alignment: Alignment.topRight,child: InkWell(onTap: (){Navigator.pop(context);},child: Image.asset('assets/images/cross.png',width: 30,))),
        Image.asset(message=="Node saved successfully"?'assets/images/success.png':'assets/images/alert.png',width: 100,),
        SingleChildScrollView(scrollDirection: Axis.vertical,child: Text(message,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),textAlign: TextAlign.center,)),
      ],),
    ),),
  ));
},);

}