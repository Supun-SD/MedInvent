import 'dart:convert';

class OTP {
  String? sendBy;
  int? OTPNumber;
  String? receiverNic;
  String? OTP_id;
  String? receiverToken ;

  OTP(
    this.OTPNumber,
    this.sendBy,
    this.receiverNic,
    this.OTP_id,
  );

  //static String userDependToJson(List<OTP> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory OTP.fromRawJson(String str) => OTP.fromJson(json.decode(str));
//

  static List<OTP> otpFromJson(String str) {
    final jsonData = json.decode(str);
    return List<OTP>.from(jsonData["data"].map((x) => OTP.fromJson(x)));
  }

  factory OTP.fromJson(Map<String, dynamic> json) => OTP(json["OTPNumber"],
      json["senderName"], json["receiverNic"], json["OTP_id"]);

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() =>
      {"receiverNic": receiverNic, "receiverToken": receiverToken};

  // @override
  // Map<String, dynamic> toJson() => {
  //   "OTP_id": OTP_id
  // };
}
