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
  String? _selectedCategory;

  LatLng? _currentP;
  final Set<Marker> _markers = {};
  final List<BitmapDescriptor> _locationIcon = [];

  List<Doctor> nearbyDoctors = [
    Doctor(
        name: "Albert Alexander",
        speciality: "Cardiologist",
        arriveTime: '5.00 PM',
        leaveTime: '7.30 PM',
        datesList: ['Monday', 'Wednesday', 'Saturday'],
        location: const LatLng(6.797554, 79.891743)),
    Doctor(
        name: "Stephen Strange",
        speciality: "Physician",
        arriveTime: '5.00 PM',
        leaveTime: '7.30 PM',
        datesList: ['Monday', 'Wednesday', 'Saturday'],
        location: const LatLng(6.800708, 79.897652)),
    Doctor(
        name: "Kapila",
        speciality: "Neurologist",
        arriveTime: '5.00 PM',
        leaveTime: '7.30 PM',
        datesList: ['Monday', 'Wednesday', 'Saturday'],
        location: const LatLng(6.793944, 79.907120)),
  ];
  List<Pharmacy> nearbyPharmacies = [
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

  void _showPopupDoctor(BuildContext context, String name, String spec,
      String arrive, String leave) {
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
              Text("Dr $name",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5.0),
              Text(spec,
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
                  Text("$arrive - $leave",
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: TextButton(
                  onPressed: () {},
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

  void _showPopupPharmacy(BuildContext context, String name, String contactNo,
      String open, String close) {
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
              Text(name,
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
                        Text(contactNo,
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
                        Text(contactNo,
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
                    "$open - $close",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: TextButton(
                  onPressed: () {},
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
              _showPopupDoctor(context, doctor.name, doctor.speciality,
                  doctor.arriveTime, doctor.leaveTime);
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
              _showPopupPharmacy(context, pharmacy.name, pharmacy.contact,
                  pharmacy.openTime, pharmacy.closeTime);
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
              _showPopupDoctor(context, doctor.name, doctor.speciality,
                  doctor.arriveTime, doctor.leaveTime);
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
              _showPopupPharmacy(context, pharmacy.name, pharmacy.contact,
                  pharmacy.openTime, pharmacy.closeTime);
            },
          ),
        );
      }
    }

    return selectedMarkers;
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
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.3),
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
                  )
                ),
              ],
            ),
    );
  }
}
