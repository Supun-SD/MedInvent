import 'package:MedInvent/features/Profile/data/models/Profile.dart';
import 'dart:convert';

class FamilyMember extends Profile {
  String? relationship;
  String? dID;

  FamilyMember(
      String? fname,
      String? lname,
      DateTime? dob,
      String? gender,
      String? picPath,
      String? nic,
      List? prescriptionsAssigned,
      this.relationship,
      this.dID
      ) : super(fname, lname, dob, gender, picPath, nic, prescriptionsAssigned);


  factory FamilyMember.fromRawJson(String str) => FamilyMember.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static List<FamilyMember> userDependFromJson(String str) {
    final jsonData = json.decode(str);
    return List<FamilyMember>.from(jsonData["data"].map((x) => FamilyMember.fromJson(x)));
  }

  static String userDependToJson(List<FamilyMember> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
      json["Fname"],
      json["Lname"],
      json["dob"] == null ? null : DateTime.parse(json["dob"]),
      json["gender"],
      json["picPath"],
      json["nic"],
      json["prescriptionsAssigned"] != null ? List.from(json["prescriptionsAssigned"]) : null,
      json["relationship"],
      json["dID"]
  );

  @override
  Map<String, dynamic> toJson() => {
    "Fname": fname,
    "Lname": lname,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "picPath": picPath,
    "nic": nic,
   // "prescriptionsAssigned": prescriptionsAssigned,
    "relationship": relationship,
    "dID":dID
  };


}
