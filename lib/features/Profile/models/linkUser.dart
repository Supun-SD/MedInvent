import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedInvent/features/login/models/user_model.dart';



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
    late User user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    Map<String, dynamic> userMap = jsonDecode(userJson!);
    user = User.fromJson(userMap);
    LoggedUserID = user.userId;
    senderName = user.fname;
    FcmToken = prefs.getString('fcm_token') ?? "";
    return true;
  }

}
