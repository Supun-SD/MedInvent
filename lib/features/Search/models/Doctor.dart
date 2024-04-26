class Doctor {
  String id;
  String fname;
  String mname;
  String lname;
  String email;
  String gender;
  String nic;
  String contactNo;
  String dob;
  String medicalLicenseNo;
  String specialization;
  String note;

  Doctor(
      {required this.id,
      required this.fname,
      required this.mname,
      required this.lname,
      required this.email,
      required this.gender,
      required this.nic,
      required this.contactNo,
      required this.dob,
      required this.medicalLicenseNo,
      required this.specialization,
      required this.note});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        id: json['doctor_id'],
        fname: json['fname'],
        mname: json['mname'],
        lname: json['lname'],
        email: json['email'],
        gender: json['gender'],
        nic: json['nic'],
        contactNo: json['contactNo'],
        dob: json['dob'],
        medicalLicenseNo: json['medical_license_no'],
        specialization: json['specialization'],
        note: json['note']);
  }
}
