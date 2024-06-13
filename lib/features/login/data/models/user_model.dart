class User {
  String userId;
  String fname;
  String lname;
  String mobileNo;
  String email;
  String nic;
  String gender;
  String dob;
  String? postalCode;
  String? lineTwo;
  String? picPath;
  PatientAddress patientAddress;

  User({
    required this.userId,
    required this.fname,
    required this.lname,
    required this.mobileNo,
    required this.email,
    required this.nic,
    required this.gender,
    required this.dob,
    this.postalCode,
    this.lineTwo,
    this.picPath,
    required this.patientAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userID'],
      fname: json['Fname'],
      lname: json['Lname'],
      mobileNo: json['mobileNo'],
      email: json['email'],
      nic: json['nic'],
      gender: json['gender'],
      dob: json['dob'],
      postalCode: json['patientAddress']['postalCode'],
      lineTwo: json['patientAddress']['lineTwo'],
      picPath: json['picPath'],
      patientAddress: PatientAddress.fromJson(json['patientAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userId,
      'Fname': fname,
      'Lname': lname,
      'mobileNo': mobileNo,
      'email': email,
      'nic': nic,
      'gender': gender,
      'dob': dob,
      'picPath': picPath,
      'patientAddress':
          patientAddress.toJson(),
    };
  }
}

class PatientAddress {
  String lineOne;
  String? lineTwo;
  String city;
  String district;
  String? postalCode;

  PatientAddress({
    required this.lineOne,
    this.lineTwo,
    required this.city,
    required this.district,
    this.postalCode,
  });

  factory PatientAddress.fromJson(Map<String, dynamic> json) {
    return PatientAddress(
      lineOne: json['lineOne'],
      lineTwo: json['lineTwo'],
      city: json['city'],
      district: json['district'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lineOne': lineOne,
      'lineTwo': lineTwo,
      'city': city,
      'district': district,
      'postalCode': postalCode,
    };
  }
}
