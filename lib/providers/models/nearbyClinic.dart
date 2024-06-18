import 'package:MedInvent/features/Search/models/session.dart';

class NearByClinic {
  String clinicId;
  String name;
  String contactNo;
  String openHoursFrom;
  String openHoursTo;
  List<String> openDays;
  String email;
  ClinicLocation location;
  List<Session> sessions;

  NearByClinic({
    required this.clinicId,
    required this.name,
    required this.contactNo,
    required this.openHoursFrom,
    required this.openHoursTo,
    required this.openDays,
    required this.email,
    required this.location,
    required this.sessions,
  });

  factory NearByClinic.fromJson(Map<String, dynamic> json) {
    return NearByClinic(
      clinicId: json['clinic_id'],
      name: json['name'],
      contactNo: json['contactNo'],
      openHoursFrom: json['openHoursFrom'],
      openHoursTo: json['openHoursTo'],
      openDays: List<String>.from(json['openDays']),
      email: json['email'],
      location: ClinicLocation.fromJson(json['location']),
      sessions:
          (json['sessions'] as List).map((i) => Session.fromJson(i)).toList(),
    );
  }
}

class ClinicLocation {
  double lat;
  double long;

  ClinicLocation({
    required this.lat,
    required this.long,
  });

  factory ClinicLocation.fromJson(Map<String, dynamic> json) {
    return ClinicLocation(
      lat: json['coordinates'][1],
      long: json['coordinates'][0],
    );
  }
}
