import 'dart:async';
import 'package:MedInvent/features/Search/models/Pharmacy.dart';
import 'package:MedInvent/features/Search/models/session.dart';
import 'package:MedInvent/features/Search/presentation/appointmentConfirmation.dart';
import 'package:MedInvent/features/Search/presentation/doctorProfile.dart';
import 'package:MedInvent/features/Search/presentation/pharmacyProfile.dart';
import 'package:MedInvent/providers/nearbyPharmaciesAndDoctorsProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:MedInvent/components/sideNavBar.dart';

import '../../providers/models/nearbyClinic.dart';

class MapPage extends ConsumerStatefulWidget {
  final String selectedCategory;
  const MapPage({super.key, required this.selectedCategory});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  String? _selectedCategory;

  late GoogleMapController mapController;

  late BitmapDescriptor myLocationIcon;
  late BitmapDescriptor doctorIcon;
  late BitmapDescriptor openPharmacyIcon;
  late BitmapDescriptor closePharmacyIcon;

  Set<Marker> pharmacyMarkers = {};
  Set<Marker> clinicsMarkers = {};
  Set<Marker> allMarkers = {};

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    initialization();
  }

  void initialization() async {
    await _loadCustomMarkerIcons();
    await ref
        .read(pharmaciesAndDoctorsProvider.notifier)
        .checkLocationPermission();
    addMarkers();
  }

  Future<void> _loadCustomMarkerIcons() async {
    myLocationIcon =
        await _getCustomMarkerIcon('assets/mapIcons/myLocation.png');
    doctorIcon = await _getCustomMarkerIcon('assets/mapIcons/doctor.png');
    openPharmacyIcon =
        await _getCustomMarkerIcon('assets/mapIcons/openPharmacy.png');
    closePharmacyIcon =
        await _getCustomMarkerIcon('assets/mapIcons/closePharmacy.png');
  }

  Future<BitmapDescriptor> _getCustomMarkerIcon(String path) async {
    ByteData byteData = await rootBundle.load(path);
    Uint8List byteList = byteData.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(byteList);
  }

  Future<void> addMarkers() async {
    pharmacyMarkers.clear();
    clinicsMarkers.clear();
    allMarkers.clear();

    List<Pharmacy> nearbyPharmacies =
        ref.watch(pharmaciesAndDoctorsProvider).nearbyPharmacies;
    List<NearByClinic> nearbyClinics =
        ref.watch(pharmaciesAndDoctorsProvider).nearbyDoctors;

    for (Pharmacy pharmacy in nearbyPharmacies) {
      Marker marker = Marker(
          markerId: MarkerId(pharmacy.id),
          position: LatLng(pharmacy.lat, pharmacy.long),
          icon: isPharmacyOpen(pharmacy.openHoursFrom, pharmacy.openHoursTo)
              ? openPharmacyIcon
              : closePharmacyIcon,
          onTap: () {
            _showPopupPharmacy(context, pharmacy);
          });
      pharmacyMarkers.add(marker);
      allMarkers.add(marker);
    }

    for (NearByClinic clinic in nearbyClinics) {
      int activeSessions = 0;
      for (Session session in clinic.sessions) {
        if (!session.isCancelled) {
          activeSessions++;
        }
      }
      if (activeSessions == 0) {
        continue;
      }
      Marker marker = Marker(
          markerId: MarkerId(clinic.clinicId),
          position: LatLng(clinic.location.lat, clinic.location.long),
          icon: doctorIcon,
          onTap: () {
            _showPopupClinic(context, clinic);
          });
      clinicsMarkers.add(marker);
      allMarkers.add(marker);
    }
    setState(() {});
  }

  void myLocationClick() async {
    await ref
        .read(pharmaciesAndDoctorsProvider.notifier)
        .checkLocationPermission();
    addMarkers();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: ref.watch(pharmaciesAndDoctorsProvider).myLocation,
        zoom: 13.8)));
  }

  void showLegend() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final double screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Center(child: Text('legend')),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/mapIcons/doctor.png",
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
                      "assets/mapIcons/openPharmacy.png",
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
                      "assets/mapIcons/closePharmacy.png",
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

  void _showPopupPharmacy(BuildContext context, Pharmacy pharmacy) {
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
              isPharmacyOpen(pharmacy.openHoursFrom, pharmacy.openHoursTo)
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
                        Text(pharmacy.contactNo,
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
                        Text(pharmacy.contactNo,
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
                    "${formatTime(pharmacy.openHoursFrom)} - ${formatTime(pharmacy.openHoursTo)}",
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
                      MaterialPageRoute(
                          builder: (context) =>
                              PharmacyProfile(pharmacy: pharmacy)),
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

  void _showPopupClinic(BuildContext context, NearByClinic clinic) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(clinic.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10.0),
                  Text(
                    clinic.contactNo,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFbae8ff),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Today sessions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                      children: clinic.sessions
                          .where((session) => !session.isCancelled)
                          .map((session) => SessionTemp(session: session))
                          .toList()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isPharmacyOpen(String openTime, String closeTime) {
    DateTime now = DateTime.now();
    List<String> openParts = openTime.split(':');
    List<String> closeParts = closeTime.split(':');

    DateTime openDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(openParts[0]),
        int.parse(openParts[1]),
        int.parse(openParts[2]));
    DateTime closeDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(closeParts[0]),
        int.parse(closeParts[1]),
        int.parse(closeParts[2]));

    return now.isAfter(openDateTime) && now.isBefore(closeDateTime);
  }

  String formatTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);

    String period = hours < 12 ? 'AM' : 'PM';

    if (hours > 12) {
      hours -= 12;
    } else if (hours == 0) {
      hours = 12;
    }

    return '$hours:${parts[1]} $period';
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    LatLng myLocation = ref.watch(pharmaciesAndDoctorsProvider).myLocation;

    Set<Marker> displayedMarkers;
    if (_selectedCategory == 'all') {
      displayedMarkers = allMarkers;
    } else if (_selectedCategory == 'doctors') {
      displayedMarkers = clinicsMarkers;
    } else {
      displayedMarkers = pharmacyMarkers;
    }

    return Scaffold(
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
            onPressed: myLocationClick,
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
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: ref.watch(pharmaciesAndDoctorsProvider).myLocation,
                  zoom: 13.8,
                ),
              ));
            },
            initialCameraPosition: CameraPosition(
              target: myLocation,
              zoom: 13.8,
            ),
            myLocationEnabled: false,
            zoomControlsEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: myLocation,
                icon: myLocationIcon,
                infoWindow: const InfoWindow(title: 'My Location'),
              ),
              ...displayedMarkers
            },
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
                  borderRadius: BorderRadius.circular(20),
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
          ref.watch(pharmaciesAndDoctorsProvider).isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: SpinKitPulsingGrid(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class SessionTemp extends StatelessWidget {
  const SessionTemp({required this.session, super.key});
  final Session session;

  String formatTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);

    String period = hours < 12 ? 'AM' : 'PM';

    if (hours > 12) {
      hours -= 12;
    } else if (hours == 0) {
      hours = 12;
    }

    return '$hours:${parts[1]} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFe3e3e3),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dr ${session.doctor.fname} ${session.doctor.lname}  (${session.doctor.specialization})",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(session.timeFrom),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              (session.activePatients < session.noOfPatients)
                  ? Text(
                      "${session.activePatients} patients",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      "Session is full",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          session.isArrived
              ? const Text(
                  "Doctor has arrived",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )
              : const Text(
                  "The doctor has not arrived yet.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorProfile(
                              doctor: session.doctor,
                            )),
                  )
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xff2980b9), width: 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                ),
                child: const Text(
                  "View Doctor",
                  style: TextStyle(
                    color: Color(0xff2980b9),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AppointmentConfirmation(session: session)),
                  )
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xff2980b9), width: 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                ),
                child: const Text(
                  "Book appointment",
                  style: TextStyle(
                    color: Color(0xff2980b9),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
