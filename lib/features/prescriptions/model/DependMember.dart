class DependMember {
  final String dID;
  final String fname;
  final String lname;
  final String relationship;

  DependMember({
    required this.dID,
    required this.fname,
    required this.lname,
    required this.relationship,
  });

  factory DependMember.fromJson(Map<String, dynamic> json) {
    return DependMember(
      dID: json['dID'],
      fname: json['Fname'],
      lname: json['Lname'],
      relationship: json['relationship'],
    );
  }
}
