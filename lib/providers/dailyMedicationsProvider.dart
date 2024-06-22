import 'package:MedInvent/config/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/Daily_medication/models/DailyMedication.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'nearbyPharmaciesAndDoctorsProvider.dart';

class DailyMedicationState {
  final List<DailyMedication> dailyMedications;
  final bool isLoading;

  DailyMedicationState(
      {required this.dailyMedications, required this.isLoading});

  factory DailyMedicationState.initial() {
    return DailyMedicationState(dailyMedications: [], isLoading: false);
  }
}

class DailyMedicationNotifier extends StateNotifier<DailyMedicationState> {
  DailyMedicationNotifier() : super(DailyMedicationState.initial());

  Future<void> fetchDailyMedications(String userID) async {
    String apiUrl =
        '${ApiConfig.baseUrl}/prescription/get/dailyMedications/$userID';
    state = DailyMedicationState(
      dailyMedications: state.dailyMedications,
      isLoading: true,
    );

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> dailyMedicationsJson = jsonResponse['data'];

          List<DailyMedication> dailyMedications = [];

          for (var json in dailyMedicationsJson) {
            DailyMedication dailyMedication = DailyMedication.fromJson(json);
            bool hasNonEmptyMedicationIntake =
                dailyMedication.presMedicine.any((medicine) {
              return medicine.medicationIntake.isNotEmpty;
            });
            if (hasNonEmptyMedicationIntake) {
              dailyMedications.add(dailyMedication);
            }
          }

          state = DailyMedicationState(
            dailyMedications: dailyMedications,
            isLoading: false,
          );
        }
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      _showSnackBar("Failed to get daily medications", 'error');
      state = DailyMedicationState(
        dailyMedications: state.dailyMedications,
        isLoading: false,
      );
    }
  }

  Future<void> updateDailyMedication(
      String id, MedicationIntake medicationIntake) async {
    String apiUrl = '${ApiConfig.baseUrl}/prescription/mark/taken/$id';

    state = DailyMedicationState(
      dailyMedications: state.dailyMedications,
      isLoading: true,
    );
    final body = jsonEncode({
      'currentStatus': medicationIntake.taken,
    });

    try {
      final response = await http.put(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: body);

      if (response.statusCode == 200) {
        medicationIntake.taken = !medicationIntake.taken;
      } else {
        throw Exception('Failed to mark the medicine as taken');
      }
    } catch (e) {
      _showSnackBar("Failed to mark the medicine as taken", "error");
    } finally {
      state = DailyMedicationState(
        dailyMedications: state.dailyMedications,
        isLoading: false,
      );
    }
  }

  void _showSnackBar(String text, String type) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
      ),
    );
  }
}

final dailyMedicationsProvider =
    StateNotifierProvider<DailyMedicationNotifier, DailyMedicationState>(
  (ref) => DailyMedicationNotifier(),
);
