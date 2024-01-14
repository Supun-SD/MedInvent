import 'dart:async';
import 'package:MedInvent/features/Search/data/doctors.dart';
import 'package:MedInvent/features/Search/data/pharmacies.dart';
import 'package:MedInvent/features/Search/doctorProfile.dart';
import 'package:MedInvent/features/Search/pharmacyProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/Search/models/categories.dart';
import 'package:MedInvent/features/Search/models/doctor.dart';
import 'package:MedInvent/features/Search/models/pharmacy.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _location = LatLng(6.9271, 79.8612);
  String? _selectedCategory;

  LatLng? _currentP;
  final Set<Marker> _markers = {};
  final List<BitmapDescriptor> _locationIcon = [];

  List<Doctor> nearbyDoctors = [
    doctors[0], doctors[1], doctors[2],
  ];
  List<Pharmacy> nearbyPharmacies = [
    pharmacies[0], pharmacies[1],
  ];

  @override
  void initState() {
    getLocationUpdates();
    _loadLocationIcon().then((value) => addMarkers());
    super.initState();
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 14,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          addMarkers();
        });
      }
    });
  }

  Future<void> _loadLocationIcon() async {
    for (int i = 1; i < 8; i++) {
      final ByteData byteData =
          await rootBundle.load('assets/mapIcons/icon$i.png');
      final Uint8List byteList = byteData.buffer.asUint8List();
      _locationIcon.add(BitmapDescriptor.fromBytes(byteList));
    }
  }

  void _showPopupDoctor(BuildContext context, Doctor doctor) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Dr ${doctor.name}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5.0),
              Text(doctor.speciality.name,
                  style: const TextStyle(
                    fontSize: 16,
                  )),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text("Available time",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  const Spacer(),
                  Text("${doctor.arriveTime} - ${doctor.leaveTime}",
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorProfile(doctor: doctor)),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2980B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'View profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _showPopupPharmacy(BuildContext context, Pharmacy pharmacy) {
    bool openStatus = true;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(pharmacy.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              openStatus
                  ? Row(
                      children: [
                        const Icon(
                          Icons.local_pharmacy,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text("Open Now"),
                        const Spacer(),
                        Text(pharmacy.contact,
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(
                          Icons.local_pharmacy,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text("Closed"),
                        const Spacer(),
                        Text(pharmacy.contact,
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text(
                    "Open time",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    "${pharmacy.openTime} - ${pharmacy.closeTime}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PharmacyProfile(pharmacy: pharmacy)),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2980B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'View profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void addMarkers() {
    _markers.clear();
    if (_currentP != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: _currentP!,
          icon: _locationIcon[0],
          infoWindow: const InfoWindow(
            title: "My Location",
          ),
        ),
      );
    }

    for (var doctor in nearbyDoctors) {
      _markers.add(
        Marker(
            markerId: MarkerId(doctor.name),
            position: doctor.location,
            icon: _locationIcon[1],
            onTap: () {
              _showPopupDoctor(context, doctor);
            }),
      );
    }

    for (var pharmacy in nearbyPharmacies) {
      _markers.add(
        Marker(
            markerId: MarkerId(pharmacy.name),
            position: pharmacy.location,
            icon: _locationIcon[5],
            onTap: () {
              _showPopupPharmacy(context, pharmacy);
            }),
      );
    }

    setState(() {});
  }

  Set<Marker> _getMarkersForSelectedCategory() {
    Set<Marker> selectedMarkers = {
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: _currentP!,
        icon: _locationIcon[0],
        infoWindow: const InfoWindow(
          title: "My Location",
        ),
      ),
    };

    if (_selectedCategory == null || _selectedCategory == 'all') {
      return Set<Marker>.of(_markers);
    } else if (_selectedCategory == 'doctors') {
      for (var doctor in nearbyDoctors) {
        selectedMarkers.add(
          Marker(
            markerId: MarkerId(doctor.name),
            position: doctor.location,
            icon: _locationIcon[1],
            onTap: () {
              _showPopupDoctor(context, doctor);
            },
          ),
        );
      }
    } else if (_selectedCategory == 'pharmacies') {
      for (var pharmacy in nearbyPharmacies) {
        selectedMarkers.add(
          Marker(
            markerId: MarkerId(pharmacy.name),
            position: pharmacy.location,
            icon: _locationIcon[5],
            onTap: () {
              _showPopupPharmacy(context, pharmacy);
            },
          ),
        );
      }
    }

    return selectedMarkers;
  }

  void showLegend() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final double screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: const Center(child: Text('legend')),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/mapIcons/icon2.png",
                      height: screenHeight * 0.04,
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    const Text("Available Doctors")
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.02,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/mapIcons/icon3.png",
                      height: screenHeight * 0.04,
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    const Text("Unavailable Doctors")
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.02,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/mapIcons/icon6.png",
                      height: screenHeight * 0.04,
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    const Text("Open Pharmacies")
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.02,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/mapIcons/icon7.png",
                      height: screenHeight * 0.04,
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    const Text("Close Pharmacies")
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SideNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Map",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _cameraToPosition(_currentP!);
            },
            backgroundColor: Colors.white,
            mini: true,
            child: const Icon(
              Icons.location_history,
              color: Colors.black,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              showLegend();
            },
            backgroundColor: Colors.white,
            mini: true,
            child: const Icon(
              Icons.legend_toggle,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: _currentP == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_off,
                        size: screenHeight * 0.08,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Turn on location service on your device",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: ((GoogleMapController controller) =>
                      _mapController.complete(controller)),
                  initialCameraPosition: const CameraPosition(
                    target: _location,
                    zoom: 13,
                  ),
                  markers: _getMarkersForSelectedCategory(),
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                ),
                Positioned(
                    top: 30.0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.3),
                      padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 50,
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'all',
                            child: Text('All'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'doctors',
                            child: Text('Doctors'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'pharmacies',
                            child: Text('Pharmacies'),
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        hint: const Text('All'),
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    )),
              ],
            ),
    );
  }
}
