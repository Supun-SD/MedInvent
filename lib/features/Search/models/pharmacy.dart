import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pharmacy{
  String name;
  String contact;
  String openTime;
  String closeTime;
  List<String> datesList;
  LatLng location;
  String address;

  Pharmacy({
    required this.name,
    required this.contact,
    required this.openTime,
    required this.closeTime,
    required this.datesList,
    required this.location,
    required this.address,
  });
}