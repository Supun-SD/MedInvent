import 'package:MedInvent/features/Profile/data/models/Profile.dart';

class FamilyMember extends Profile {
  String relationship;
  FamilyMember(super.name, this.relationship, super.NIC, super.gender,
      super.dob, super.prescriptionsAssigned);
}
