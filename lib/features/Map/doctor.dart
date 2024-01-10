import 'package:google_maps_flutter/google_maps_flutter.dart';

class Doctor {
  String name;
  String arriveTime;
  String leaveTime;
  List<String> datesList;
  LatLng location;

  Doctor({
    required this.name,
    required this.arriveTime,
    required this.leaveTime,
    required this.datesList,
    required this.location,
  });

}
