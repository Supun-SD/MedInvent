import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  String message ="";

  @override
  void didChangedependencies(){
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;


    if(arguments != null)
      {
        Map? pushArguments =arguments as Map;
        setState(() {
          message= pushArguments["message"];
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("push message : $message"),
        ),
      ),
    );
  }
}
