import 'package:flutter/material.dart';

class DailyMed extends StatefulWidget {
  const DailyMed({super.key});

  @override
  State<DailyMed> createState() => _DailyMedState();
}

class _DailyMedState extends State<DailyMed> {


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF474CA0),
                  Color(0xFF468FA0),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text('Daily Medications'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: screenHeight * 0.1,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight * 0.06),
                  topRight: Radius.circular(screenHeight * 0.06),
                ),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 50,
            child: Text(
              'Fever  Prescription',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 350.0,
            height: 350.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: screenHeight * 0.02,
                  blurRadius: screenHeight * 0.1,
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(
                20.0,250.0,20.0,210
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                CustomWidget(),
                SizedBox(height: 2.0,),
                Divider(height: 3.0,color: Colors.black12,),
                CustomWidget(),
                SizedBox(height: 2.0,),
                Divider(height: 2.0,color: Colors.blue[700],),
                CustomWidget(),
                SizedBox(height: 2.0,),

                Container(
                  padding: EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,

                  ),
                  child: TextButton(
                    onPressed: (){},
                    child: Text('More Details',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.blue,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        side: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                        fixedSize: Size(80.0, 5.0)

                    ),
                  ),

                ),
              ],
            ),



          ),
        ],
      ),
    );
  }
}




class CustomWidget extends StatefulWidget {

  const CustomWidget({super.key});


  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  final borderRadius = BorderRadius.circular(5.0);
  int numberOfTablets = 0;
  int days_left = 0;
  String nameOfMed = 'Panadol';
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(0.6),
              decoration: BoxDecoration(
                  color: Colors.black12, borderRadius: borderRadius),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: SizedBox.fromSize(
                  size: Size.fromRadius(20),
                  child: Image.asset(
                    'assets/images/med.jpeg',
                  ),
                ),
              ),
            ),
            SizedBox(width: 7.8),
            Column(
              children: [

                Text('$nameOfMed * $numberOfTablets',
                  style: TextStyle(
                      fontSize: 9.0

                  ),
                ),

                SizedBox(height: 2.0),

                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0)

                  ),
                  child: Text(' $days_left days left ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.0
                    ),
                  ),
                ),


              ],
            ),



            SizedBox(width: 130.0),
            Text('Time',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),

            Checkbox(value: isChecked, onChanged: (bool? value){
              setState(() {
                isChecked = value!;
              });
            })

          ],
        ),

      ],
    );

  }
}







