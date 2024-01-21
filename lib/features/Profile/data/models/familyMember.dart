import 'package:MedInvent/features/prescriptions/model/docPrescription.dart';

class FamilyMember {
  String name;
  String relationship;
  String NIC;
  String gender;
  String dob;
  List<DocPrescription> prescriptionsAssigned;

  FamilyMember(this.name, this.relationship, this.NIC, this.gender, this.dob,
      this.prescriptionsAssigned);
}
