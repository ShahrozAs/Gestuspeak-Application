import 'package:flutter/material.dart';
import 'package:gestuspeak/helper/alphabet_images.dart';

class UserGuidePage extends StatefulWidget {
    const UserGuidePage({super.key});

  @override
  State<UserGuidePage> createState() => _UserGuidePageState();
}

class _UserGuidePageState extends State<UserGuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Guide"),
      ),
      body:ListView.builder(itemBuilder: (context, index) {
      
        return Container(
          margin: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(flex: 1,child: Container(height: 250,child: Image.asset(alphabetSymbols[index]))),
              SizedBox(width: 5,),
              Expanded(flex: 1, child: Card(elevation: 0.1, color: Color(0xffF2F2F2) , child: Container(height: 250,padding: EdgeInsets.all(20),child: Align(alignment:Alignment.center,child: Text(aslDescriptions[index],style:  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17),)))))
            ],
          ),
        );
      },itemCount: alphabetSymbols.length,)
    );
  }
}

