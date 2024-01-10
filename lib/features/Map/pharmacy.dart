import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pharmacy{
  String name;
  String openTime;
  String closeTime;
  List<String> datesList;
  LatLng location;

  Pharmacy({
    required this.name,
    required this.openTime,
    required this.closeTime,
    required this.datesList,
    required this.location,
  });
}