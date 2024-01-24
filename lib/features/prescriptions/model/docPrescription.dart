import 'package:MedInvent/features/prescriptions/model/prescription.dart';

class DocPrescription extends Prescription {
  String doctor;

  DocPrescription(super.title, super.dateIssued, this.doctor,
      super.assignedMember, super.prescribedMedicine);
}
