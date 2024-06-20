class DailyMedication {
  String prescriptionId;
  String presName;
  List<Medicine> presMedicine;

  DailyMedication({
    required this.prescriptionId,
    required this.presName,
    required this.presMedicine,
  });

  factory DailyMedication.fromJson(Map<String, dynamic> json) {
    return DailyMedication(
      prescriptionId: json['prescription_id'],
      presName: json['presName'],
      presMedicine: (json['presMedicine'] as List)
          .map((i) => Medicine.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prescription_id': prescriptionId,
      'presName': presName,
      'presMedicine': presMedicine.map((i) => i.toJson()).toList(),
    };
  }
}

class Medicine {
  String medicineId;
  String name;
  int qty;
  String frq;
  String mealTiming;
  List<MedicationIntake> medicationIntake;

  Medicine({
    required this.medicineId,
    required this.name,
    required this.qty,
    required this.frq,
    required this.mealTiming,
    required this.medicationIntake,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineId: json['medicine_id'],
      name: json['name'],
      qty: json['qty'],
      frq: json['frq'],
      mealTiming: json['mealTiming'],
      medicationIntake: (json['medicationIntake'] as List)
          .map((i) => MedicationIntake.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicine_id': medicineId,
      'name': name,
      'qty': qty,
      'frq': frq,
      'mealTiming': mealTiming,
      'medicationIntake': medicationIntake.map((i) => i.toJson()).toList(),
    };
  }
}

class MedicationIntake {
  String id;
  String time;
  bool taken;

  MedicationIntake({
    required this.id,
    required this.time,
    required this.taken,
  });

  factory MedicationIntake.fromJson(Map<String, dynamic> json) {
    return MedicationIntake(
      id: json['id'],
      time: json['time'],
      taken: json['taken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'taken': taken,
    };
  }
}
