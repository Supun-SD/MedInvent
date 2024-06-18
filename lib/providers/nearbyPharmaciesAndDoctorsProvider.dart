import 'package:MedInvent/features/Search/models/Pharmacy.dart';
import 'package:MedInvent/providers/models/nearbyClinic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../config/api.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class PharmaciesAndDoctorsState {
  final List<Pharmacy> nearbyPharmacies;
  final List<NearByClinic> nearbyDoctors;
  final LatLng myLocation;
  final bool isLoading;

  PharmaciesAndDoctorsState({
    required this.nearbyPharmacies,
    required this.nearbyDoctors,
    required this.myLocation,
    required this.isLoading,
  });

  factory PharmaciesAndDoctorsState.initial() {
    return PharmaciesAndDoctorsState(
      nearbyPharmacies: [],
      nearbyDoctors: [],
      myLocation: const LatLng(6.927079, 79.861243),
      isLoading: false,
    );
  }
}

class PharmaciesAndDoctorsNotifier
    extends StateNotifier<PharmaciesAndDoctorsState> {
  PharmaciesAndDoctorsNotifier() : super(PharmaciesAndDoctorsState.initial());

  Location location = Location();

  Future<void> fetchNearbyPharmacies(double lat, double long) async {
    String pharmaciesApiUrl =
        '${ApiConfig.baseUrl}/pharmacy/getnearby?lat=$lat&long=$long';
    String doctorsApiUrl =
        '${ApiConfig.baseUrl}/clinic/getnearby?lat=$lat&long=$long';

    _setLoading(true);

    try {
      final pharmaciesResponse = await http.get(Uri.parse(pharmaciesApiUrl));
      final doctorsResponse = await http.get(Uri.parse(doctorsApiUrl));

      if (pharmaciesResponse.statusCode == 200 &&
          doctorsResponse.statusCode == 200) {
        List<Pharmacy> nearbyPharmacies =
            _parsePharmacies(pharmaciesResponse.body);
        List<NearByClinic> nearbyDoctors = _parseDoctors(doctorsResponse.body);

        state = PharmaciesAndDoctorsState(
          nearbyPharmacies: nearbyPharmacies,
          nearbyDoctors: nearbyDoctors,
          myLocation: state.myLocation,
          isLoading: false,
        );
      } else {
        throw Exception('Failed to load nearby pharmacies and clinics');
      }
    } catch (e) {
      print(e);
      if (mounted) {
        _showErrorSnackBar('Failed to load nearby pharmacies and clinics.');
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> checkLocationPermission() async {
    _setLoading(true);

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _setLoading(false);
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _setLoading(false);
        return;
      }
    }

    await getLocation();
  }

  Future<void> getLocation() async {
    _setLoading(true);
    try {
      LocationData locationData = await location.getLocation();
      state = PharmaciesAndDoctorsState(
        nearbyPharmacies: state.nearbyPharmacies,
        nearbyDoctors: state.nearbyDoctors,
        myLocation: LatLng(locationData.latitude!, locationData.longitude!),
        isLoading: state.isLoading,
      );
      if (locationData.longitude == null || locationData.latitude == null) {
        throw Exception('Failed to get current location');
      }
      await fetchNearbyPharmacies(
          locationData.latitude!, locationData.longitude!);
    } catch (error) {
      _showErrorSnackBar('Error getting location data.');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool isLoading) {
    state = PharmaciesAndDoctorsState(
      nearbyPharmacies: state.nearbyPharmacies,
      nearbyDoctors: state.nearbyDoctors,
      myLocation: state.myLocation,
      isLoading: isLoading,
    );
  }

  List<NearByClinic> _parseDoctors(String responseBody) {
    final parsed = json.decode(responseBody);
    List<NearByClinic> clinics = [];
    if (parsed['data'] != null) {
      for (var clinic in parsed['data']) {
        NearByClinic c = NearByClinic.fromJson(clinic);
        clinics.add(c);
      }
    }
    return clinics;
  }

  List<Pharmacy> _parsePharmacies(String responseBody) {
    final parsed = json.decode(responseBody);
    List<Pharmacy> pharmacies = [];
    if (parsed['data'] != null) {
      for (var pharmacy in parsed['data']) {
        Pharmacy p = Pharmacy.fromJson(pharmacy);
        pharmacies.add(p);
      }
    }
    return pharmacies;
  }

  void _showErrorSnackBar(String text) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
      ),
    );
  }
}

final pharmaciesAndDoctorsProvider = StateNotifierProvider<
    PharmaciesAndDoctorsNotifier,
    PharmaciesAndDoctorsState>((ref) => PharmaciesAndDoctorsNotifier());
