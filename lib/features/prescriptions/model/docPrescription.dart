import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/prescriptions/model/prescribedMedicine.dart';

class DocPrescription {
  String title;
  String dateIssued;
  String doctor;
  FamilyMember? assignedMember;
  List<PrescribedMedicine> prescribedMedicine;

  DocPrescription(this.title, this.dateIssued, this.doctor,  this.assignedMember,
      this.prescribedMedicine);
}
