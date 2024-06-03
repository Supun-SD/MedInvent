import 'package:MedInvent/features/prescriptions/model/Prescription.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/prescriptions/presentation/DocPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/presentation/MyPrescriptions.dart';
import 'package:MedInvent/components/CustomTabBar.dart';
import 'package:flutter/material.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({super.key});

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  List<Prescription> prescriptions = [];
  List<Prescription> docPrescriptions = [];
  List<Prescription> userPrescriptions = [];
  bool isLoading = false;

  String userID = "126b4f01-e486-461e-b20e-311e3c7c0ffb";

  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
    String apiUrl =
        '${ApiConfig.baseUrl}/prescription/getAllPrescriptions/$userID';
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> prescriptionsJson = jsonResponse['data'];

          docPrescriptions.clear();
          userPrescriptions.clear();

          for (var json in prescriptionsJson) {
            Prescription prescription = Prescription.fromJson(json);
            if (prescription.createdBy == 'doctor') {
              docPrescriptions.add(prescription);
            } else if (prescription.createdBy == 'user') {
              userPrescriptions.add(prescription);
            }
          }
        }
      } else {
        throw Exception('Failed to load prescriptions');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get prescriptions.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const SideNavBar(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        title: const Text("Prescriptions"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(screenHeight * 0.05)),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return const AssignNewPrescription();
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF474CA0),
                    Color(0xFF468FA0),
                  ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.025),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.035),
                  child: CustomTabBar(tabTitles: const [
                    "Doctor's Prescriptions",
                    "My Prescriptions"
                  ], tabViews: [
                    DocPresContent(
                      docPrescriptions: docPrescriptions,
                    ),
                    MyPresContent(
                      userPrescriptions: userPrescriptions,
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
