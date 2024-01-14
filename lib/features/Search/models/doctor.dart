import 'package:MedInvent/features/Search/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Doctor {
  String name;
  Categories speciality;
  TimeOfDay arriveTime;
  TimeOfDay leaveTime;
  List<String> datesList;
  LatLng location;

  Doctor({
    required this.name,
    required this.speciality,
    required this.arriveTime,
    required this.leaveTime,
    required this.datesList,
    required this.location,
  });
}
