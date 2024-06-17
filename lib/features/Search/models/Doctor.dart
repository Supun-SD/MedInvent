class Doctor {
  String? id;
  String fname;
  String mname;
  String lname;
  String? email;
  String? gender;
  String? nic;
  String? contactNo;
  String? dob;
  String? medicalLicenseNo;
  String? specialization;
  String? note;

  Doctor(
      {this.id,
      required this.fname,
      required this.mname,
      required this.lname,
      this.email,
      this.gender,
      this.nic,
      this.contactNo,
      this.dob,
      this.medicalLicenseNo,
      this.specialization,
      this.note});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        id: json['doctor_id'] ?? null,
        fname: json['fname'],
        mname: json['mname'],
        lname: json['lname'],
        email: json['email'] ?? null,
        gender: json['gender'] ?? null,
        nic: json['nic'] ?? null,
        contactNo: json['contactNo'] ?? null,
        dob: json['dob'] ?? null,
        medicalLicenseNo: json['medical_license_no'] ?? null,
        specialization: json['specialization'] ?? null,
        note: json['note'] ?? null);
  }
}
