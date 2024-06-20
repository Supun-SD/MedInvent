import 'dart:convert';

class CancelSession {
  String? doctorFullName;
  String? clinicName;
  DateTime? date;
  String? userID;
  String? cancel_id;

  CancelSession(
      this.doctorFullName,
      this.clinicName,
      this.date,
      this.userID,
      this.cancel_id,
      );

  //static String userDependToJson(List<OTP> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory CancelSession.fromRawJson(String str) => CancelSession.fromJson(json.decode(str));


  static List<CancelSession> otpFromJson(String str) {
    final jsonData = json.decode(str);
    return List<CancelSession>.from(jsonData["data"].map((x) => CancelSession.fromJson(x)));
  }


  factory CancelSession.fromJson(Map<String, dynamic> json) => CancelSession(
      json["doctorFullName"],
      json["clinicName"],
      json["date"] == null ? null : DateTime.parse(json["date"]),
      json["userID"],
      json["cancel_id"]
  );

  String toRawJson() => json.encode(toJson());

  @override
  Map<String, dynamic> toJson() => {
     "cancel_id":cancel_id
  };

// @override
// Map<String, dynamic> toJson() => {
//   "OTP_id": OTP_id
// };

}
