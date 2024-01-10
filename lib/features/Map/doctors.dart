import 'package:MedInvent/features/Map/doctor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Doctor> doctors = [
  Doctor(
      name: "Albert Alexander",
      arriveTime: '5.00 PM',
      leaveTime: '7.30 PM',
      datesList: ['Monday', 'Wednesday', 'Saturday'],
      location: const LatLng(6.797554, 79.891743)),
  Doctor(
      name: "Stephen Strange",
      arriveTime: '5.00 PM',
      leaveTime: '7.30 PM',
      datesList: ['Monday', 'Wednesday', 'Saturday'],
      location: const LatLng(6.800708, 79.897652)),
  Doctor(
      name: "Kapila",
      arriveTime: '5.00 PM',
      leaveTime: '7.30 PM',
      datesList: ['Monday', 'Wednesday', 'Saturday'],
      location: const LatLng(6.793944, 79.907120)),
];
