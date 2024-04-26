import 'dart:async';
import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Search/models/Pharmacy.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:MedInvent/components/sideNavBar.dart';

class MapPage extends StatefulWidget {
  final String selectedCategory;
  const MapPage({super.key, required this.selectedCategory});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? _selectedCategory;

  late GoogleMapController mapController;
  Location location = Location();
  LatLng currentLocation = const LatLng(6.927079, 79.861243);
  bool isLoading = false;

  late BitmapDescriptor myLocationIcon;
  late BitmapDescriptor doctorIcon;
  late BitmapDescriptor openPharmacyIcon;
  late BitmapDescriptor closePharmacyIcon;

  List<Pharmacy> nearbyPharmacies = [];

  Set<Marker> pharmacyMarkers = {};
  Set<Marker> doctorMarkers = {};

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _checkLocationPermission();
    _loadCustomMarkerIcons();
  }

  Future<void> fetchNearbyPharmacies() async {
    String apiUrl =
        '${ApiConfig.baseUrl}/pharmacy/getnearby?lat=${currentLocation.latitude.toString()}&long=${currentLocation.longitude.toString()}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> pharmaciesJson = jsonResponse['data'];

          nearbyPharmacies.clear();
          pharmacyMarkers.clear();

          for (var pharmacyJson in pharmaciesJson) {
            Pharmacy pharmacy = Pharmacy.fromJson(pharmacyJson);
            nearbyPharmacies.add(pharmacy);

            Marker marker = Marker(
                markerId: MarkerId(pharmacy.id),
                position: LatLng(pharmacy.lat, pharmacy.long),
                icon:
                    isPharmacyOpen(pharmacy.openHoursFrom, pharmacy.openHoursTo)
                        ? openPharmacyIcon
                        : closePharmacyIcon,
                onTap: () {
                  _showPopupPharmacy(context, pharmacy);
                });
            pharmacyMarkers.add(marker);
          }
        }
      } else {
        throw Exception('Failed to load nearby pharmacies');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get nearby pharmacies.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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

  Future<void> _checkLocationPermission() async {
    setState(() {
      isLoading = true;
    });

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          isLoading = false;
        });
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          isLoading = false;
        });
        return;
      }
    }

    getLocation();
  }

  void getLocation() async {
    setState(() {
      isLoading = true;
    });
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 15.0)));
      });
      await fetchNearbyPharmacies();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error getting location data.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void myLocationClick() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 15.0)));
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           PharmacyProfile(pharmacy: pharmacy)),
                    // );
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
            },
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 15.0,
            ),
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: currentLocation,
                icon: myLocationIcon,
                infoWindow: const InfoWindow(title: 'My Location'),
              ),
              ...pharmacyMarkers
            },
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
          isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: SpinKitWave(
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
