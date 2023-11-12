import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() =>_HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(children:[
          //app bar
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child:Row(
                children:[
                  Text(
                    'HI Dhanushka'
                  )
                ]
              )
          ),

          //medication card

          //appoinment cards
        ]),
      )

    );
  }
}