import 'dart:async';
import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/Map/doctor.dart';
import 'package:MedInvent/features/Map/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _location = LatLng(6.9271, 79.8612);

  LatLng? _currentP;
  final List<Marker> _markers = <Marker>[];
  final List<BitmapDescriptor> _locationIcon = [];

  List<Doctor> nearbyDoctors = [
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
        location: const LatLng(6.793944, 79.907120))
  ];
  List<Pharmacy> nearbyPharmacies = [
    Pharmacy(
        name: "Harcourts Pharmacy",
        openTime: "9.00 AM",
        closeTime: "8.00 PM",
        datesList: ['Monday', 'Tuesday', 'Wednesday'],
        location: const LatLng(6.783916, 79.904922)),
    Pharmacy(
        name: "Halo Pharmacy",
        openTime: "9.00 AM",
        closeTime: "8.00 PM",
        datesList: ['Monday', 'Tuesday', 'Wednesday'],
        location: const LatLng(6.788014, 79.892936)),
  ];

  @override
  void initState() {
    getLocationUpdates();
    addMarkers();
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

  void addMarkers() async {
    await _loadLocationIcon();

    _markers.clear();
    if (_currentP != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: _currentP!,
          icon: _locationIcon[0],
        ),
      );
    }

    for (var doctor in nearbyDoctors) {
      _markers.add(
        Marker(
          markerId: MarkerId(doctor.name),
          position: doctor.location,
          icon: _locationIcon[1],
        ),
      );
    }

    for (var pharmacy in nearbyPharmacies) {
      _markers.add(
        Marker(
          markerId: MarkerId(pharmacy.name),
          position: pharmacy.location,
          icon: _locationIcon[5],
        ),
      );
    }

    setState(() {});
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
      floatingActionButton: FloatingActionButton(
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
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: const CameraPosition(
                target: _location,
                zoom: 13,
              ),
              markers: Set<Marker>.of(_markers),
              myLocationEnabled: false,
              zoomControlsEnabled: false,
            ),
    );
  }
}
