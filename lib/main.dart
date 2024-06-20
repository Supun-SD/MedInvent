import 'dart:convert';
import 'package:MedInvent/providers/nearbyPharmaciesAndDoctorsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/Register/presentation/pages/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'features/Notifications/notificationDisplay.dart';
import 'package:firebase_analytics/observer.dart';
import 'features/login/presentation/pages/checkLog.dart';
import 'features/Notifications/otpNotification.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.instance.getToken().then((value) => {
    print("get token : $value")
  });

  FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) async{
      print("onMessageOpenedApp : $message");
      Navigator.pushNamed(navigatorKey.currentState!.context,
        '/',
        arguments: {
          "message":json.encode(message.data)
        },
      );
    },
  );

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) =>{
    if(message!=null){
      Navigator.pushNamed(navigatorKey.currentState!.context, '/',
        arguments: {
          "message":json.encode(message.data)
        },
      )
    }
  },
  );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: MyApp()));
}

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async
  {
    await Firebase.initializeApp();
    print("_firebaseMessagingBackgroundHandler : $message");
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Raleway'),
      //home:  CheckAuth(),
      navigatorKey:navigatorKey,
       routes: {
         '/':((context)=> CheckAuth()),
         '/notifications':((context)=>const OTPNotification()),
         '/landing':((contex)=>const Landing())
       },
    );
  }
}

