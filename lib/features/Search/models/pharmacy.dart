import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pharmacy {
  String name;
  String contact;
  TimeOfDay openTime;
  TimeOfDay closeTime;
  List<String> datesList;
  LatLng location;
  String address;
  List<Review> reviews;

  Pharmacy({
    required this.name,
    required this.contact,
    required this.openTime,
    required this.closeTime,
    required this.datesList,
    required this.location,
    required this.address,
    required this.reviews,
  });
}

class Review {
  String name;
  int stars;
  String review;

  Review(this.name, this.stars, this.review);
}
