import 'dart:convert';

class DoctorArrival {
  String? doctorFullName;
  String? clinicName;
  DateTime? date;
  String? userID;
  String? arrive_id;
  String? session_id;

  DoctorArrival(
    this.doctorFullName,
    this.clinicName,
    this.date,
    this.userID,
    this.arrive_id,
    this.session_id,
  );

  //static String userDependToJson(List<OTP> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory DoctorArrival.fromRawJson(String str) =>
      DoctorArrival.fromJson(json.decode(str));

  static List<DoctorArrival> otpFromJson(String str) {
    final jsonData = json.decode(str);
    return List<DoctorArrival>.from(
        jsonData["data"].map((x) => DoctorArrival.fromJson(x)));
  }

  factory DoctorArrival.fromJson(Map<String, dynamic> json) => DoctorArrival(
      json["doctorFullName"],
      json["clinicName"],
      json["date"] == null ? null : DateTime.parse(json["date"]),
      json["userID"],
      json["arrive_id"],
      json["session_id"]);

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {"arrive_id": arrive_id};

// @override
// Map<String, dynamic> toJson() => {
//   "OTP_id": OTP_id
// };
}
