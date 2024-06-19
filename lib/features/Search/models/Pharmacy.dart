class Pharmacy{
  String id;
  String name;
  String contactNo;
  String openHoursFrom;
  String openHoursTo;
  List<String> openDays;
  String? email;
  double lat;
  double long;
  String addressLineOne;
  String? addressLineTwo;
  String city;
  String district;

  Pharmacy({
    required this.id,
    required this.name,
    required this.contactNo,
    required this.openHoursFrom,
    required this.openHoursTo,
    required this.openDays,
    required this.email,
    required this.lat,
    required this.long,
    required this.addressLineOne,
    required this.addressLineTwo,
    required this.city,
    required this.district,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['pharmacy_id'],
      name: json['name'],
      contactNo: json['contactNo'],
      openHoursFrom: json['openHoursFrom'],
      openHoursTo: json['openHoursTo'],
      openDays: List<String>.from(json['openDays']),
      email: json['email'],
      lat: json['location']['coordinates'][1],
      long: json['location']['coordinates'][0],
      addressLineOne: json['pharmacyAddress']['lineOne'],
      addressLineTwo: json['pharmacyAddress']['lineTwo'],
      city: json['pharmacyAddress']['city'],
      district: json['pharmacyAddress']['district'],
    );
  }
}