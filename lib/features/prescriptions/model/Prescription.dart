import 'package:MedInvent/features/prescriptions/model/DependMember.dart';
import 'package:MedInvent/features/prescriptions/model/NewPrescription.dart';

class Prescription {
  String prescriptionId;
  String presName;
  String createdBy;
  String? doctorName;
  String createdAt;
  String updatedAt;
  String userId;
  String? assignedTo;
  String? dID;
  DependMember? dependMember;
  List<PresMedicine> presMedicine;

  Prescription({
    required this.prescriptionId,
    required this.presName,
    required this.createdBy,
    this.doctorName,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    this.assignedTo,
    this.dID,
    this.dependMember,
    required this.presMedicine,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      prescriptionId: json['prescription_id'],
      presName: json['presName'],
      createdBy: json['createdBy'],
      doctorName: json['doctorName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['userID'],
      assignedTo: json['assignedTo'],
      dID: json['dID'],
      dependMember: json['dependMember'] != null
          ? DependMember.fromJson(json['dependMember'])
          : null,
      presMedicine: (json['presMedicine'] as List)
          .map((i) => PresMedicine.fromJson(i))
          .toList(),
    );
  }
}

class PresMedicine {
  String? medicineId;
  String name;
  int qty;
  String frq;
  String mealTiming;
  int duration;
  int remainingDays;
  List<String>? reminders;
  String? prescriptionId;

  PresMedicine({
    this.medicineId,
    required this.name,
    required this.qty,
    required this.frq,
    required this.mealTiming,
    required this.duration,
    required this.remainingDays,
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
      remainingDays: json['remainingDays'],
      reminders: json['reminders'] != null
          ? List<String>.from(json['reminders'])
          : null,
      prescriptionId: json['prescription_id'],
    );
  }
}

Prescription mapNewPrescriptionToPrescription(
  NewPrescription newPrescription,
  String userId,
  String prescriptionId,
  String createdAt,
  String updatedAt,
) {
  List<PresMedicine> presMedicines = newPrescription.presMedicine.map((newMed) {
    return PresMedicine(
      name: newMed.name,
      qty: newMed.qty,
      frq: newMed.frq,
      mealTiming: newMed.mealTiming,
      duration: newMed.duration,
      remainingDays: newMed.duration,
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
    assignedTo: newPrescription.assignedTo,
    dID: newPrescription.dID,
    dependMember:
        newPrescription.dID != null ? newPrescription.dependMember : null,
    presMedicine: presMedicines,
  );
}
