import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/prescriptions/model/prescribedMedicine.dart';

class MyPrescription{
  late String title;
  late String dateIssued;
  late FamilyMember? assignedMember;
  List<PrescribedMedicine> prescribedMedicine = [];
}