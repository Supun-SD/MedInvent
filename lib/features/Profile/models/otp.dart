import 'dart:convert';

class OTP {
  String? sendBy;
  int? OTPNumber;
  String? receiverNic;
  String? OTP_id;
  String? receiverToken =
      "cK8Aj-QcRRaf-C_6I9m27H:APA91bF7xsjFWF8t7X-10vAHsDao1rfvBvfTVdTRJXVIx-r99j5N1uruLGAkcUkf-fj8lUQp7ZoN5eNhqYRLc9HaqvdgtMu4-1M10xnivkokwO614dDahYMyVtNKR3CgXY-EqyjiPh6K";

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
