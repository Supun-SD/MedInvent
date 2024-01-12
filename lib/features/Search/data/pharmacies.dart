import 'package:MedInvent/features/Search/models/pharmacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Pharmacy> pharmacies = [
  Pharmacy(
      name: "Harcourts Pharmacy",
      contact: "+94771234567",
      openTime: "9.00 AM",
      closeTime: "8.00 PM",
      datesList: ['Monday', 'Tuesday', 'Wednesday', 'Friday', 'Sunday'],
      location: const LatLng(6.791256, 79.901482),
      address: "No.304 Sri Vajiragnana Mawatha, Colombo 9"),
  Pharmacy(
      name: "Halo Pharmacy",
      contact: "+94778545662",
      openTime: "9.00 AM",
      closeTime: "8.00 PM",
      datesList: ['Monday', 'Tuesday', 'Wednesday'],
      location: const LatLng(6.788014, 79.892936),
      address: "No. 56, Galle Road, Colombo 3"),
  Pharmacy(
      name: "Harcourts Pharmacy",
      contact: "+94771234567",
      openTime: "9.00 AM",
      closeTime: "8.00 PM",
      datesList: ['Monday to Friday'],
      location: const LatLng(6.791256, 79.901482),
      address: "No. 123, Kandy Road, Kandy"),
  Pharmacy(
      name: "Halo Pharmacy",
      contact: "+94778545662",
      openTime: "9.00 AM",
      closeTime: "8.00 PM",
      datesList: ['Everyday'],
      location: const LatLng(6.788014, 79.892936),
      address: "No. 789, Negombo Road, Negombo"),
];
