import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LinkUser {
  String? relationship;
  String? receiverID;
  String? receiverNic;
  String? mobileNo;
  List<String> FcmTokens = [];
  String LoggedUserID = "";
  String FcmToken = "";
  int OTPNumber = 1;
  String senderName = "";

  LinkUser(this.mobileNo, this.receiverID, this.receiverNic, this.relationship);

  String toRawJson() => json.encode(toJson());

  // Method to convert LinkUser to JSON for the get user Tokens API request
  String toRawJsonForSecondRequest() => json.encode(toJsonForSecondRequest());

  // Method to send OTPs to user devices
  String toRawJsonForThirdRequest() => json.encode(toJsonForThirdRequest());

  //Method to check entered OTP
  String toRawJsonForFourthRequest() => json.encode(toJsonForFourthRequest());

  //Method to add users dependent finally
  String toRawJsonForFifthRequest() => json.encode(toJsonForFifthRequest());

  Map<String, dynamic> toJson() => {"mobileNo": mobileNo, "nic": receiverNic};

  Map<String, dynamic> toJsonForSecondRequest() => {
        "userID": receiverID,
      };

  //send OTPs to user devices
  Map<String, dynamic> toJsonForThirdRequest() => {
        "FcmTokens": FcmTokens,
        "senderName": senderName,
        "senderUUID": LoggedUserID,
        "receiverNic": receiverNic
      };

  //check entered OTP
  Map<String, dynamic> toJsonForFourthRequest() => {
        "OTPNumber": OTPNumber,
        "senderUUID": LoggedUserID,
        "receiverNic": receiverNic
      };

  //add users dependent finally
  Map<String, dynamic> toJsonForFifthRequest() => {
        "mobileNo": mobileNo,
        "nic": receiverNic,
        "relationship": relationship,
        "userID": LoggedUserID
      };

  //get logged data from shared preferences
  Future<bool> assignLoggedUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoggedUserID = prefs.getString('userID') ?? "";
    senderName = prefs.getString('Fname') ?? "";
    FcmToken = prefs.getString('FcmToken') ?? "";
    return true;
  }

  Future<bool> temporary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('FcmToken',
        "cK8Aj-QcRRaf-C_6I9m27H:APA91bF7xsjFWF8t7X-10vAHsDao1rfvBvfTVdTRJXVIx-r99j5N1uruLGAkcUkf-fj8lUQp7ZoN5eNhqYRLc9HaqvdgtMu4-1M10xnivkokwO614dDahYMyVtNKR3CgXY-EqyjiPh6K");
    await prefs.setString('Fname', "Jane");
    await prefs.setString('userID', "550e8400-e29b-41d4-a716-446655440000");
    return true;
  }
}
