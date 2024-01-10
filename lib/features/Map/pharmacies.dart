import 'package:MedInvent/features/Map/pharmacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Pharmacy> pharmacies = [
  Pharmacy(
      name: "Harcourts Pharmacy",
      contact: "+94771234567",
      openTime: "9.00 AM",
      closeTime: "8.00 PM",
      datesList: ['Monday', 'Tuesday', 'Wednesday'],
      location: const LatLng(6.791256, 79.901482)),
  Pharmacy(
      name: "Halo Pharmacy",
      contact: "+94778545662",
      openTime: "9.00 AM",
      closeTime: "8.00 PM",
      datesList: ['Monday', 'Tuesday', 'Wednesday'],
      location: const LatLng(6.788014, 79.892936)),
];
