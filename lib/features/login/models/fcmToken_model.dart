import 'dart:convert';

class FCM {
  String? userId;
  String fcm_token;
  bool isActiveToken = false;

  FCM(
    this.userId,
    this.fcm_token,
  );

  String toRawJson() => json.encode(toJson());
  String toRawJson_two() => json.encode(toJson_two());

  Map<String, dynamic> toJson() => {"userID": userId, "fcm_token": fcm_token};

  Map<String, dynamic> toJson_two() => {
        "userID": userId,
        "fcm_token": fcm_token,
        "isActiveToken": isActiveToken
      };
}
