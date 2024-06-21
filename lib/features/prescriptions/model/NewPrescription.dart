import 'package:MedInvent/features/prescriptions/model/DependMember.dart';

class NewPrescription {
  late String presName;
  late String? assignedTo;
  late String? dID;
  late DependMember? dependMember;
  late List<NewPresMedicine> presMedicine;

  Map<String, dynamic> toJson(String createdBy, String userId) {
    return {
      'presData': {
        'presName': presName,
        'createdBy': createdBy,
        'userID': userId,
        'assignedTo': assignedTo,
        'dID': dID
      },
      'presMedicines':
          presMedicine.map((medicine) => medicine.toJson()).toList(),
    };
  }
}

class NewPresMedicine {
  late String name;
  late int qty;
  late String frq;
  late String mealTiming;
  late int duration;
  late List<String> reminders;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'qty': qty,
      'frq': frq,
      'mealTiming': mealTiming,
      'duration': duration,
      'reminders': reminders,
    };
  }
}
