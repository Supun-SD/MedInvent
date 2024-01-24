import 'package:MedInvent/features/prescriptions/model/prescribedMedicine.dart';

class Prescription{
  String title;
  String dateIssued;
  var assignedMember;
  List<PrescribedMedicine> prescribedMedicine;

  Prescription(this.title, this.dateIssued,this.assignedMember,
      this.prescribedMedicine);
}