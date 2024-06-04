import 'package:MedInvent/features/prescriptions/model/NewPrescription.dart';

class Prescription {
  String prescriptionId;
  String presName;
  String createdBy;
  String doctorName;
  String createdAt;
  String updatedAt;
  String userId;
  List<PresMedicine> presMedicine;
  var assignedTo;

  Prescription({
    required this.prescriptionId,
    required this.presName,
    required this.createdBy,
    required this.doctorName,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.presMedicine,
    this.assignedTo,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
        prescriptionId: json['prescription_id'],
        presName: json['presName'],
        createdBy: json['createdBy'],
        doctorName: json['doctorName'] == null ? "N/A" : json['doctorName'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        userId: json['userID'],
        presMedicine: (json['presMedicine'] as List)
            .map((i) => PresMedicine.fromJson(i))
            .toList(),
        assignedTo: null);
  }
}

class PresMedicine {
  String? medicineId;
  String name;
  int qty;
  String frq;
  String mealTiming;
  int duration;
  List<String>? reminders;
  String? prescriptionId;

  PresMedicine({
    this.medicineId,
    required this.name,
    required this.qty,
    required this.frq,
    required this.mealTiming,
    required this.duration,
    this.reminders,
    this.prescriptionId,
  });

  factory PresMedicine.fromJson(Map<String, dynamic> json) {
    return PresMedicine(
      medicineId: json['medicine_id'],
      name: json['name'],
      qty: json['qty'],
      frq: json['frq'],
      mealTiming: json['mealTiming'],
      duration: json['duration'],
      reminders: json['reminders'] != null
          ? List<String>.from(json['reminders'])
          : null,
      prescriptionId: json['prescription_id'],
    );
  }
}

Prescription mapNewPrescriptionToPrescription(
    NewPrescription newPrescription, String userId, String prescriptionId, String createdAt, String updatedAt) {
  List<PresMedicine> presMedicines = newPrescription.presMedicine.map((newMed) {
    return PresMedicine(
      name: newMed.name,
      qty: newMed.qty,
      frq: newMed.frq,
      mealTiming: newMed.mealTiming,
      duration: newMed.duration,
      reminders: newMed.reminders,
    );
  }).toList();

  return Prescription(
    prescriptionId: prescriptionId,
    presName: newPrescription.presName,
    createdBy: 'user',
    doctorName: '',
    createdAt: createdAt,
    updatedAt: updatedAt,
    userId: userId,
    presMedicine: presMedicines,
  );
}
