import 'package:MedInvent/features/prescriptions/model/DependMember.dart';
import 'package:MedInvent/features/prescriptions/model/NewPrescription.dart';
import 'package:MedInvent/features/prescriptions/model/Prescription.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../config/api.dart';

class PrescriptionsState {
  final List<Prescription> docPrescriptions;
  final List<Prescription> userPrescriptions;
  final bool isLoading;

  PrescriptionsState({
    required this.docPrescriptions,
    required this.userPrescriptions,
    required this.isLoading,
  });

  factory PrescriptionsState.initial() {
    return PrescriptionsState(
      docPrescriptions: [],
      userPrescriptions: [],
      isLoading: false,
    );
  }
}

class PrescriptionsNotifier extends StateNotifier<PrescriptionsState> {
  PrescriptionsNotifier() : super(PrescriptionsState.initial());

  Future<void> fetchPrescriptions(BuildContext context, String userID) async {
    String apiUrl =
        '${ApiConfig.baseUrl}/prescription/getAllPrescriptions/$userID';
    state = PrescriptionsState(
      docPrescriptions: state.docPrescriptions,
      userPrescriptions: state.userPrescriptions,
      isLoading: true,
    );

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> prescriptionsJson = jsonResponse['data'];

          List<Prescription> docPrescriptions = [];
          List<Prescription> userPrescriptions = [];

          for (var json in prescriptionsJson) {
            Prescription prescription = Prescription.fromJson(json);
            if (prescription.createdBy == 'doctor') {
              docPrescriptions.add(prescription);
            } else if (prescription.createdBy == 'user') {
              userPrescriptions.add(prescription);
            }
          }

          state = PrescriptionsState(
            docPrescriptions: docPrescriptions,
            userPrescriptions: userPrescriptions,
            isLoading: false,
          );
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
      state = PrescriptionsState(
        docPrescriptions: state.docPrescriptions,
        userPrescriptions: state.userPrescriptions,
        isLoading: false,
      );
    }
  }

  Future<void> addUserPrescription(BuildContext context,
      NewPrescription newPrescription, String userID) async {
    state = PrescriptionsState(
        docPrescriptions: state.docPrescriptions,
        userPrescriptions: state.userPrescriptions,
        isLoading: true);
    String apiUrl = '${ApiConfig.baseUrl}/prescription/newprescription';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(newPrescription.toJson("user", userID)),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data'];

        state = PrescriptionsState(
          docPrescriptions: state.docPrescriptions,
          userPrescriptions: [
            mapNewPrescriptionToPrescription(newPrescription, data['userID'],
                data['prescription_id'], data['createdAt'], data['updatedAt']),
            ...state.userPrescriptions
          ],
          isLoading: false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prescription created successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to add prescription');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add prescription.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      PrescriptionsState(
          docPrescriptions: state.docPrescriptions,
          userPrescriptions: state.userPrescriptions,
          isLoading: false);
    }
  }

  Future<void> updatePrescription(String presId, String medicineId,
      List<String> reminders, BuildContext context) async {
    final String apiUrl = '${ApiConfig.baseUrl}/prescription/update/$presId';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'medicineId': medicineId,
      'reminders': reminders,
    });

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prescription updated successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to update the prescription');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating the prescription.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> assignPrescription(Prescription prescription, String assignedTo,
      DependMember? member, BuildContext context) async {
    state = PrescriptionsState(
        docPrescriptions: state.docPrescriptions,
        userPrescriptions: state.userPrescriptions,
        isLoading: true);

    final String apiUrl =
        '${ApiConfig.baseUrl}/prescription/assign/${prescription.prescriptionId}';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'assignedTo': assignedTo,
      'dID': member?.dID,
    });

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        prescription.assignedTo = assignedTo;
        prescription.dID = member?.dID;
        prescription.dependMember = member;

        final updatedPrescription = Prescription(
          prescriptionId: prescription.prescriptionId,
          presName: prescription.presName,
          createdBy: prescription.createdBy,
          doctorName: prescription.doctorName,
          createdAt: prescription.createdAt,
          updatedAt: prescription.updatedAt,
          userId: prescription.userId,
          assignedTo: assignedTo,
          dID: member?.dID,
          dependMember: member,
          presMedicine: prescription.presMedicine,
        );

        if (prescription.createdBy == 'doctor') {
          state = PrescriptionsState(
            docPrescriptions: state.docPrescriptions.map((p) {
              return p.prescriptionId == prescription.prescriptionId
                  ? updatedPrescription
                  : p;
            }).toList(),
            userPrescriptions: state.userPrescriptions,
            isLoading: false,
          );
        } else {
          state = PrescriptionsState(
              docPrescriptions: state.docPrescriptions,
              userPrescriptions: state.userPrescriptions.map((p) {
                return p.prescriptionId == prescription.prescriptionId
                    ? updatedPrescription
                    : p;
              }).toList(),
              isLoading: false);
        }
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prescription assigned successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to assign the prescription');
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to assign the prescription.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

final prescriptionsProvider =
    StateNotifierProvider<PrescriptionsNotifier, PrescriptionsState>(
  (ref) => PrescriptionsNotifier(),
);
