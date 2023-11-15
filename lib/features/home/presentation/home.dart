import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:MedInvent/presentation/components/sideNavBar.dart';
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
      backgroundColor: Colors.white,
      drawer: const SideNavBar(),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const SafeArea(
        child: Column(children:[
          //app bar
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child:Row(
                children:[
                  Text(
                    'HI Dhanushka'
                  )
                ]
              )
          ),

          //medication card

          //appointment cards
        ]),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}