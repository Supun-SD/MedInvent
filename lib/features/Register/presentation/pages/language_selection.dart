// import 'package:flutter/material.dart';
// import 'package:MedInvent/features/login/presentation/pages/login.dart';
//
// class LanguageSelection extends StatelessWidget {
//   const LanguageSelection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         margin:
//             EdgeInsets.fromLTRB(screenWidth * 0.15, 0, screenWidth * 0.15, 0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset('assets/images/logo.png'),
//               SizedBox(
//                 height: screenHeight * 0.12,
//               ),
//               Text(
//                 'Select a language to continue',
//                 style: TextStyle(
//                   fontSize: screenHeight * 0.02,
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.05,
//               ),
//               languageSelectionButton(context, 'English', const LoginPage(),
//                   screenWidth, screenHeight),
//               languageSelectionButton(context, 'සිංහල', const LoginPage(),
//                   screenWidth, screenHeight),
//               languageSelectionButton(context, 'தமிழ்', const LoginPage(),
//                   screenWidth, screenHeight),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget languageSelectionButton(BuildContext context, String text, Widget nav,
//       double screenWidth, double screenHeight) {
//     return Container(
//       margin: EdgeInsets.fromLTRB(0, screenHeight * 0.02, 0, 0),
//       child: Container(
//         width: screenWidth * 0.5,
//         height: screenHeight * 0.07,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(screenHeight * 0.1),
//           color: const Color(0xFF2980B9),
//         ),
//         child: TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => nav),
//             );
//           },
//           child: Text(
//             text,
//             style: TextStyle(
//               fontSize: screenHeight * 0.022,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
