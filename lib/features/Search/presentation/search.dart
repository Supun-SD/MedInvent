import 'dart:convert';
import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Search/data/medicines.dart';
import 'package:MedInvent/features/Search/presentation/doctorProfile.dart';
import 'package:MedInvent/features/Search/presentation/medicineProfile.dart';
import 'package:MedInvent/features/Search/models/Doctor.dart';
import 'package:MedInvent/features/Search/models/Pharmacy.dart';
import 'package:MedInvent/features/Search/presentation/pharmacyProfile.dart';
import 'package:MedInvent/providers/models/nearbyClinic.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/providers/nearbyPharmaciesAndDoctorsProvider.dart';
import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/Search/presentation/advancedSearch.dart';
import 'package:MedInvent/features/Search/data/categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  String selectedValue = 'Doctors';
  TextEditingController search = TextEditingController();

  bool isLoading = true;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(pharmaciesAndDoctorsProvider.notifier)
          .checkLocationPermission();
    });
  }

  List<Doctor> doctors = [];
  List<Pharmacy> pharmacies = [];
  List displayMedicine = List.from(medicines);

  Future<void> fetchPharmacies() async {
    if (search.text.isEmpty) {
      return;
    }

    String apiUrl =
        '${ApiConfig.baseUrl}/pharmacy/get/getByName/${search.text}';
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> pharmaciesJson = jsonResponse['data'];

          pharmacies.clear();

          for (var pharmacyJson in pharmaciesJson) {
            Pharmacy pharmacy = Pharmacy.fromJson(pharmacyJson);
            pharmacies.add(pharmacy);
          }
        }
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get results'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchDoctors() async {
    if (search.text.isEmpty) {
      return;
    }

    String apiUrl = '${ApiConfig.baseUrl}/doctor/get/getByName/${search.text}';
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> doctorsJson = jsonResponse['data'];

          doctors.clear();

          for (var doctorJson in doctorsJson) {
            Doctor doctor = Doctor.fromJson(doctorJson);
            doctors.add(doctor);
          }
        }
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get results'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateMedicineList(String value) {
    setState(() {
      displayMedicine = medicines
          .where((medicine) =>
              medicine.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    bool isNearbyLoading = ref.watch(pharmaciesAndDoctorsProvider).isLoading;

    List<Pharmacy> nearbyPharmacies =
        ref.watch(pharmaciesAndDoctorsProvider).nearbyPharmacies;
    List<NearByClinic> nearbyClinics =
        ref.watch(pharmaciesAndDoctorsProvider).nearbyDoctors;
    List<Doctor> nearbyDoctors = [];

    Set<String> doctorIds = {};

    for (var clinic in nearbyClinics) {
      for (var session in clinic.sessions) {
        if (!doctorIds.contains(session.doctor.id)) {
          doctorIds.add(session.doctor.id!);
          nearbyDoctors.add(session.doctor);
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SideNavBar(),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Search'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF474CA0),
                        Color(0xFF468FA0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.02,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 15)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              value: selectedValue,
                              items: <String>[
                                'Doctors',
                                'Pharmacies',
                                'Medicine'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              underline: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              controller: search,
                              onChanged: (String value) {
                                setState(() {
                                  if (selectedValue == 'Doctors') {
                                    fetchDoctors();
                                  } else if (selectedValue == 'Pharmacies') {
                                    fetchPharmacies();
                                  } else if (selectedValue == 'Medicine') {
                                    updateMedicineList(value);
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search for $selectedValue',
                                hintStyle:
                                    TextStyle(fontSize: screenWidth * 0.035),
                                border: InputBorder.none,
                                icon: const Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.12,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: importantCategories.map((category) {
                            return Category(category: category);
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Text(
                        "Nearby Doctors",
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      if (isNearbyLoading)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.05),
                          child: const SpinKitCircle(
                            size: 30,
                            color: Colors.blue,
                          ),
                        )
                      else
                        nearbyDoctors.isEmpty
                            ? Container(
                                margin: EdgeInsets.only(
                                    right: screenWidth * 0.05,
                                    top: screenHeight * 0.02,
                                    bottom: screenHeight * 0.02),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.05,
                                    horizontal: screenWidth * 0.1),
                                child: const Text(
                                  "There are no any doctors with sessions near you today",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: nearbyDoctors.map((doctor) {
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.02),
                                        child: NearbyDoctor(
                                          doctor: doctor,
                                        ));
                                  }).toList(),
                                ),
                              ),
                      SizedBox(
                        height: screenHeight * 0.015,
                      ),
                      Text(
                        "Nearby Pharmacies",
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      if (isNearbyLoading)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.05),
                          child: const SpinKitCircle(
                            size: 30,
                            color: Colors.blue,
                          ),
                        )
                      else
                        nearbyPharmacies.isEmpty
                            ? Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    right: screenWidth * 0.05,
                                    top: screenHeight * 0.02,
                                    bottom: screenHeight * 0.02),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.05,
                                    horizontal: screenWidth * 0.1),
                                child: const Text(
                                  "There are no any pharmacies near you",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  ...nearbyPharmacies
                                      .map((p) => NearbyPharmacy(
                                            pharmacy: p,
                                          ))
                                      .toList(),
                                ],
                              ),
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
              if (search.text.isNotEmpty)
                Positioned(
                  top: screenHeight * 0.11,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        if (selectedValue == 'Doctors')
                          if (!isLoading)
                            if (doctors.isNotEmpty)
                              ...doctors.map((doctor) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorProfile(doctor: doctor),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: ListTile(
                                        selectedTileColor: Colors.grey,
                                        title: Text(
                                          '${doctor.fname} ${doctor.lname}',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.035),
                                        ),
                                      ),
                                    ),
                                  ))
                            else
                              Padding(
                                padding: EdgeInsets.all(screenWidth * 0.1),
                                child: const Text('No result'),
                              )
                          else
                            Padding(
                              padding: EdgeInsets.all(screenHeight * 0.05),
                              child: SpinKitFadingCircle(
                                color: Colors.blueAccent,
                                size: screenWidth * 0.08,
                              ),
                            )
                        else if (selectedValue == 'Pharmacies')
                          if (!isLoading)
                            if (pharmacies.isNotEmpty)
                              ...pharmacies.map((pharmacy) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PharmacyProfile(
                                              pharmacy: pharmacy),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: ListTile(
                                        selectedTileColor: Colors.grey,
                                        title: Text(
                                          pharmacy.name,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.035),
                                        ),
                                      ),
                                    ),
                                  ))
                            else
                              Padding(
                                padding: EdgeInsets.all(screenWidth * 0.1),
                                child: const Text('No result'),
                              )
                          else
                            Padding(
                              padding: EdgeInsets.all(screenHeight * 0.05),
                              child: SpinKitFadingCircle(
                                color: Colors.blueAccent,
                                size: screenWidth * 0.08,
                              ),
                            )
                        else if (selectedValue == 'Medicine')
                          if (displayMedicine.isNotEmpty)
                            ...displayMedicine.map((medicine) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MedicineProfile(medicine: medicine),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: ListTile(
                                      selectedTileColor: Colors.grey,
                                      title: Text(
                                        medicine.name,
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035),
                                      ),
                                    ),
                                  ),
                                ))
                          else
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.1),
                              child: const Text('No result'),
                            ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({required this.category, super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdvancedSearch(category: category)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFF1578B6).withOpacity(0.67),
            const Color(0xFF626599),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
            child: Text(
              category,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class NearbyDoctor extends StatelessWidget {
  const NearbyDoctor({required this.doctor, super.key});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoctorProfile(doctor: doctor)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(5, 0)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Image.asset(
                'assets/images/doctor.jpg',
                height: screenHeight * 0.15,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${doctor.fname} ${doctor.lname}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.028),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  Text(
                    doctor.specialization!,
                    style: TextStyle(fontSize: screenWidth * 0.025),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NearbyPharmacy extends StatelessWidget {
  const NearbyPharmacy({required this.pharmacy, super.key});

  final Pharmacy pharmacy;

  void openDialer() async {
    final Uri dialNumber = Uri(
      scheme: 'tel',
      path: pharmacy.contactNo,
    );
    try {
      if (await canLaunchUrl(dialNumber)) {
        await launchUrl(dialNumber);
      } else {
        throw 'Could not launch $dialNumber';
      }
    } catch (e) {
      _showError("Error");
    }
  }

  void openGoogleMaps() async {
    final Uri googleMapsUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps',
      queryParameters: {
        'q': '${pharmacy.lat},${pharmacy.long}(${pharmacy.name})',
        'z': '15',
      },
    );
    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri);
      } else {
        throw 'Could not launch $googleMapsUri';
      }
    } catch (e) {
      _showError("Error");
    }
  }

  void _showError(String text) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PharmacyProfile(pharmacy: pharmacy)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
            right: screenWidth * 0.06, bottom: screenHeight * 0.015),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Text(pharmacy.name),
            const Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: openGoogleMaps,
                    icon: const Icon(Icons.location_on_outlined)),
                IconButton(
                    onPressed: openDialer,
                    icon: const Icon(Icons.call_outlined)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
