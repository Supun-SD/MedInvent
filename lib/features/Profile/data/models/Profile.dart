import 'dart:convert';

class Profile {
  String? fname;
  String? lname;
  DateTime? dob;
  String? gender;
  String? picPath;
  String? nic;
  List? prescriptionsAssigned;

  Profile(
      this.fname,
      this.lname,
      this.dob,
      this.gender,
      this.picPath,
      this.nic,
      this.prescriptionsAssigned
      );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    json["Fname"],
    json["Lname"],
    json["dob"] == null ? null : DateTime.parse(json["dob"]),
    json["gender"],
    json["picPath"],
    json["nic"],
    json["prescriptionsAssigned"] != null ? List.from(json["prescriptionsAssigned"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "Fname": fname,
    "Lname": lname,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "picPath": picPath,
    "nic": nic,
    "prescriptionsAssigned": prescriptionsAssigned,
  };
}
