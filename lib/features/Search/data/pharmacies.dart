import 'package:MedInvent/features/Search/models/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Pharmacy> pharmacies = [
  Pharmacy(
      name: "Halo Pharmacy",
      contact: "+94778545662",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Everyday'],
      location: const LatLng(6.778527, 79.900524),
      address: "No. 789, Negombo Road, Negombo",
      reviews: [
        Review('John Doe', 5, 'Excellent product. Highly recommended!'),
      ]),
  Pharmacy(
      name: "MediCare Solutions",
      contact: "+94772345678",
      openTime: const TimeOfDay(hour: 9, minute: 30),
      closeTime: const TimeOfDay(hour: 20, minute: 30),
      datesList: ['Everyday'],
      location: const LatLng(7.293498, 80.634563),
      address: "No. 123, Kandy Street, Kandy",
      reviews: [
        Review('Samuel Brown', 3, 'Decent products, but a bit pricey.'),
      ]),
  Pharmacy(
      name: "Green Leaf Pharmacy",
      contact: "+94783456789",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Everyday'],
      location: const LatLng(6.054166, 80.217002),
      address: "No. 789, Gampaha Avenue, Gampaha",
      reviews: [
        Review('Emily Johnson', 5,
            'Quick service and a wide range of medications.'),
      ]),
  Pharmacy(
      name: "Healthy Choice Pharmacy",
      contact: "+94794567890",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Everyday'],
      location: const LatLng(5.954345, 80.549964),
      address: "No. 234, Matara Street, Matara",
      reviews: [
        Review('David White', 4, 'Good selection of health products.'),
      ]),
  Pharmacy(
      name: "Sunrise Medicos",
      contact: "+94785678901",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Everyday'],
      location: const LatLng(7.873054, 80.771797),
      address: "No. 567, Anuradhapura Road, Anuradhapura",
      reviews: [
        Review('Olivia Davis', 5,
            'Excellent customer service and affordable prices.'),
      ]),
  Pharmacy(
      name: "Healthy Choice Pharmacy",
      contact: "+94794567890",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Everyday'],
      location: const LatLng(6.809906, 79.976399),
      address: "No. 234, Matara Street, Matara",
      reviews: [
        Review('David White', 4, 'Good selection of health products.'),
      ]),
  Pharmacy(
      name: "Wellness Drugs",
      contact: "+94761234567",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Everyday'],
      location: const LatLng(6.927079, 79.861244),
      address: "No. 456, Galle Road, Colombo",
      reviews: [
        Review('Jane Smith', 4, 'Great service and friendly staff.'),
      ]),
  Pharmacy(
      name: "Sunrise Medicos",
      contact: "+94785678901",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Everyday'],
      location: const LatLng(6.807552, 79.981248),
      address: "No. 567, Anuradhapura Road, Anuradhapura",
      reviews: [
        Review('Olivia Davis', 5,
            'Excellent customer service and affordable prices.'),
      ]),
  Pharmacy(
      name: "Harcourts Pharmacy",
      contact: "+94771234567",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Monday', 'Tuesday', 'Wednesday', 'Friday', 'Sunday'],
      location: const LatLng(6.791256, 79.901482),
      address: "No.304 Sri Vajiragnana Mawatha, Colombo 9",
      reviews: [
        Review(
            'Olivia Taylor', 4, 'Good customer support. Resolved my issues.'),
        Review(
            'David Martinez', 3, 'It\'s okay. Expected more from the brand.'),
        Review('Emma Anderson', 5, 'Fantastic experience. Will buy again.')
      ]),
  Pharmacy(
      name: "Halo Pharmacy",
      contact: "+94778545662",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Monday', 'Tuesday', 'Wednesday'],
      location: const LatLng(6.788014, 79.892936),
      address: "No. 56, Galle Road, Colombo 3",
      reviews: [
        Review('John Doe', 5, 'Excellent product. Highly recommended!'),
        Review('Jane Smith', 4, 'Good quality but a bit pricey.'),
      ]),
  Pharmacy(
      name: "Harcourts Pharmacy",
      contact: "+94771234567",
      openTime: const TimeOfDay(hour: 9, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
      datesList: ['Monday to Friday'],
      location: const LatLng(6.809390, 79.895344),
      address: "No. 123, Kandy Road, Kandy",
      reviews: [
        Review('Alice Johnson', 3, 'Average experience. Could be better.'),
        Review(
            'Bob Brown', 2, 'Not satisfied. Product didn\'t meet expectations.')
      ]),
];
