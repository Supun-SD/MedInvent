import 'package:flutter/material.dart';

class AppointmentSuccess extends StatelessWidget {
  const AppointmentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/payment.png",
                width: screenWidth * 0.3,
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Text(
                "Your appointment is placed successfully",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10,),
              Text("Check your mail for the receipt",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                  )),
              SizedBox(
                height: screenHeight * 0.3,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2980B9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(
                          fontSize: screenWidth * 0.035, color: Colors.white),
                    )),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
