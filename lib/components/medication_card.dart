import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Medication_card extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String medication1;
  final String medication2;
  final String User;
  final color;

  const Medication_card({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.medication1,
    required this.medication2,
    required this.User,
    required this.color,

  }) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: screenWidth*0.59,
        height: screenHeight*0.1,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: screenHeight * 0.1,
              blurRadius: screenHeight * 0.5,
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(

          children: [

            Text('$User Daily Medications',),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: Colors.white,
                child: Text(
                  "$medication1 Medication",
                  style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold ),
                ),
              ),
            ),

            SizedBox(height: 5),
            Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: screenHeight * 0.01,
                          blurRadius: screenHeight * 0.25,
                        ),
                      ],
                      color: color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  child: StepProgressIndicator(
                    totalSteps: 12,
                    currentStep:6,
                    size: 25,
                    padding: 0,
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey,
                    roundedEdges: Radius.circular(10),
                    selectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color.fromARGB(150, 63, 195, 128), Colors.black12],
                    ),
                    unselectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black12, Colors.black12],

                    ),


                  ),

                )

              ],
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined,size: 10,),
                      Text("8.00AM", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined,size: 10),
                      Text("1.00PM", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined,size: 10,),
                      Text("8.00PM", style: TextStyle(fontSize: 11)),
                    ],
                  ),
            ],
            ),

            SizedBox(height: 10),





            Align(
              
              alignment: Alignment.centerLeft,
              child: Container(
                color: Colors.white,
                child: Text(
                  "$medication2 Medication",
                  style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold ),
                ),
              ),
            ),

            SizedBox(height: 5),
            StepProgressIndicator(
              totalSteps: 2,
              currentStep: 2,
              size: 25,
              padding: 0,
              selectedColor: Colors.green,
              unselectedColor: Colors.grey,
              roundedEdges: Radius.circular(10),
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(150, 63, 195, 128), Colors.black12],
              ),
              unselectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black12, Colors.black12],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined,size: 10,),
                    Text("8.00AM", style: TextStyle(fontSize: 11)),
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.watch_later_outlined,size: 10,),
                    Text("8.00PM", style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),


          ],
        ),
      ),

    );
  }
}

class StepProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final double size;
  final double padding;
  final Color selectedColor;
  final Color unselectedColor;
  final Radius roundedEdges;
  final Gradient selectedGradientColor;
  final Gradient unselectedGradientColor;

  StepProgressIndicator({
    required this.totalSteps,
    required this.currentStep,
    this.size = 2,
    this.padding = 2,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.roundedEdges = const Radius.circular(0),
    this.selectedGradientColor = const LinearGradient(
      colors: [Colors.blue, Colors.green],
    ),
    this.unselectedGradientColor = const LinearGradient(
      colors: [Colors.grey, Colors.grey],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(roundedEdges),
            gradient: unselectedGradientColor,
          ),
        ),
        Container(
          width: size * currentStep,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(roundedEdges),
            gradient: selectedGradientColor,
          ),
        ),
        Positioned(
          left: size * (currentStep - 1),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(roundedEdges),
              color: Colors.transparent,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}